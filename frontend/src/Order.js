import './App.css';
import React, { useState, useEffect } from 'react';
import { useNavigate } from "react-router-dom";
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.css';
import { Container, Table, Button, Form, Modal, Navbar, Card, Accordion } from 'react-bootstrap';

axios.defaults.xsrfCookieName = 'csrftoken';
axios.defaults.xsrfHeaderName = 'X-CSRFToken';
axios.defaults.withCredentials = true;

const client = axios.create({
  baseURL: "http://localhost:8000"
});

const Order = ({ onLogout }) => {
    const navigate = useNavigate();

    function submitLogout(e) {
        e.preventDefault();
        client.post(
          "/api/logout",
          {withCredentials: true}
        ).then(onLogout());
      }
      
    return (
      <div>
          <Navbar bg="dark" variant="dark">
          <Container>
              <Navbar.Text>
              <Button type="submit" variant="light" onClick={() => navigate(-1)}>Back</Button>
              </Navbar.Text>
              <Navbar.Brand>Ordering system</Navbar.Brand>
              <Navbar.Collapse className="justify-content-end">
              <Navbar.Text>
                  <form onSubmit={e => submitLogout(e)}>
                  <Button type="submit" variant="light">Log out</Button>
                  </form>
              </Navbar.Text>
              </Navbar.Collapse>
          </Container>
          </Navbar>
          <h1>Order Page</h1>
      </div>
    );
  };
  
  export default Order;