import './App.css';
import React from 'react';
import { Link } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.css';
import { Container, Button, Navbar, Card, Row, Col} from 'react-bootstrap';

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
        <Container className="text-center mt-5">
        <h2>Choose a system:</h2>
        <Row className="justify-content-center mt-4">
          <Col md={4} className="d-flex justify-content-center">
            <Link to="/Order" className="w-100">
              <Button variant="primary" size="lg" className="w-100">
                Order
              </Button>
            </Link>
          </Col>
          <Col md={4} className="d-flex justify-content-center">
            <Link to="/Kitchen" className="w-100">
              <Button variant="success" size="lg" className="w-100">
                Kitchen
              </Button>
            </Link>
          </Col>
          {isAdmin && (
            <Col md={4} className="d-flex justify-content-center">
              <Link to="/admin" className="w-100">
                <Button variant="danger" size="lg" className="w-100">
                  Admin
                </Button>
              </Link>
            </Col>
          )}
        </Row>
      </Container>
    </div>
    );
};

export default HomePage;
