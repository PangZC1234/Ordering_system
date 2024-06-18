import './App.css';
import React from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.css';
import Container from 'react-bootstrap/Container';
import Navbar from 'react-bootstrap/Navbar';
import Button from 'react-bootstrap/Button';


axios.defaults.xsrfCookieName = 'csrftoken';
axios.defaults.xsrfHeaderName = 'X-CSRFToken';
axios.defaults.withCredentials = true;

const client = axios.create({
  baseURL: "http://localhost:8000"
});

const HomePage = ({ onLogout, isAdmin }) => {

    function submitLogout(e) {
        e.preventDefault().then(onLogout());
    }

    return (
    <div>
        <Navbar bg="dark" variant="dark">
        <Container>
            <Navbar.Brand>Ordering system</Navbar.Brand>
            <Navbar.Toggle />
            <Navbar.Collapse className="justify-content-end">
            <Navbar.Text>
                <form onSubmit={e => submitLogout(e)}>
                <Button type="submit" href="/logout" variant="light">Log out</Button>
                </form>
            </Navbar.Text>
            </Navbar.Collapse>
        </Container>
        </Navbar>
        <div className="center">
            <h2>Choose a system:</h2>
            <Link to="/Order">Order</Link>
            <Link to="/Kitchen">Kitchen</Link>
            {isAdmin && <Link to="/admin">Admin</Link>} {/* Conditionally render the admin button */}
        </div>
        </div>
    );
};

export default HomePage;
