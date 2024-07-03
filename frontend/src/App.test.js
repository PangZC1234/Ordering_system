import React from 'react';
import { render, fireEvent, waitFor, screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import LoginPage from './LoginPage';
import axios from 'axios';

// Mock the entire axios module
jest.mock('axios', () => {
  const mockAxios = {
    create: jest.fn(() => mockAxios),
    post: jest.fn(),
    defaults: {
      headers: {
        common: {},
      },
    },
  };
  return mockAxios;
});

describe('LoginPage', () => {
  beforeEach(() => {
    // Clear all mocks before each test
    jest.clearAllMocks();

    // Mock localStorage
    Object.defineProperty(window, 'localStorage', {
      value: {
        getItem: jest.fn(),
        setItem: jest.fn(),
        clear: jest.fn(),
      },
      writable: true
    });

    // Mock window.location
    delete window.location;
    window.location = { href: jest.fn() };
  });

  it('renders login form by default', () => {
    render(<LoginPage />);
    expect(screen.getByLabelText(/email address/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/password/i)).toBeInTheDocument();
    expect(screen.getByText(/submit/i)).toBeInTheDocument();
    expect(screen.getByText(/register/i)).toBeInTheDocument();
  });

  it('toggles to registration form when Register button is clicked', () => {
    render(<LoginPage />);
    fireEvent.click(screen.getByText(/register/i));
    expect(screen.getByLabelText(/email address/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/username/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/password/i)).toBeInTheDocument();
    expect(screen.getByText(/submit/i)).toBeInTheDocument();
    expect(screen.getByText(/log in/i)).toBeInTheDocument();
  });

  it('redirects to home page on successful login', async () => {
    const { getByLabelText, getByText } = render(<LoginPage />);
    
    fireEvent.change(getByLabelText(/email address/i), { target: { value: 'test@example.com' } });
    fireEvent.change(getByLabelText(/password/i), { target: { value: 'password123' } });

    axios.create().post.mockResolvedValueOnce({ data: { access: 'access_token', refresh: 'refresh_token' } });

    fireEvent.click(getByText(/submit/i));

    await waitFor(() => {
      expect(window.location.href).toBe('/');
    });
  });

  it('displays error message on login failure', async () => {
    render(<LoginPage />);
    fireEvent.change(screen.getByLabelText(/email address/i), { target: { value: 'test@example.com' } });
    fireEvent.change(screen.getByLabelText(/password/i), { target: { value: 'wrongpassword' } });

    axios.post.mockRejectedValueOnce({ response: { status: 401 } });

    fireEvent.click(screen.getByText(/submit/i));

    await waitFor(() => {
      expect(screen.getByText('Invalid email or password')).toBeInTheDocument();
    });
  });

  it('redirects to home page on successful registration', async () => {
    const { getByLabelText, getByText } = render(<LoginPage />);
    
    fireEvent.click(getByText(/register/i));

    fireEvent.change(getByLabelText(/email address/i), { target: { value: 'newuser@example.com' } });
    fireEvent.change(getByLabelText(/username/i), { target: { value: 'newuser' } });
    fireEvent.change(getByLabelText(/password/i), { target: { value: 'newpassword123' } });

    axios.create().post.mockResolvedValueOnce({}) // Registration request
                      .mockResolvedValueOnce({ data: { access: 'access_token', refresh: 'refresh_token' } }); // Login request

    fireEvent.click(getByText(/submit/i));

    await waitFor(() => {
      expect(window.location.href).toBe('/');
    });
  });

  it('displays error message on registration failure', async () => {
    render(<LoginPage />);
    fireEvent.click(screen.getByText(/register/i));
    
    fireEvent.change(screen.getByLabelText(/email address/i), { target: { value: 'existinguser@example.com' } });
    fireEvent.change(screen.getByLabelText(/username/i), { target: { value: 'existinguser' } });
    fireEvent.change(screen.getByLabelText(/password/i), { target: { value: 'password123' } });

    axios.post.mockRejectedValueOnce({ response: { data: { errors: ['Email already exists'] } } });

    fireEvent.click(screen.getByText(/submit/i));

    await waitFor(() => {
      expect(screen.getByText('Email already exists')).toBeInTheDocument();
    });
  });
});