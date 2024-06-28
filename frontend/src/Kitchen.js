import './App.css';
import React, { useState, useEffect } from 'react';
import { useNavigate } from "react-router-dom";
import 'bootstrap/dist/css/bootstrap.css';
import { Container, Button, Navbar, Card, Row, Col} from 'react-bootstrap';
import client from './Client';

const Kitchen = ({ onLogout }) => {
    const navigate = useNavigate();
    const [invoices, setInvoices] = useState([]);
    const [orders, setOrders] = useState([]);
    const [menus, setMenus] = useState([]);
    const [showArchived, setShowArchived] = useState(false);

    useEffect(() => {
      fetchtables();
    }, []);

    const fetchtables = async () => {
      try {
        const [invoicesResponse, ordersResponse, menusResponse] = await Promise.all([
          client.get('/api/invoices/'),
          client.get('/api/orders/'),
          client.get('/api/menus/')
        ]);
        setInvoices(invoicesResponse.data);
        setOrders(ordersResponse.data);
        setMenus(menusResponse.data);
      } catch (error) {
        console.error('Failed to fetch invoices or orders:', error);
      }
    };

    const handleDecreaseQuantity = async (order) => {
      try {
        if (order.current_quantity > 0) {
          await client.patch(`/api/orders/${order.id}/`, { current_quantity: order.current_quantity - 1 });
          fetchtables(); // Refresh data after updating
        }
      } catch (error) {
        console.error('Failed to decrease quantity:', error);
      }
    };
  
    const handleDone = async (invoiceId) => {
      try {
        await client.patch(`/api/invoices/${invoiceId}/`, { archive_flag: true });
        fetchtables(); // Refresh data after updating
      } catch (error) {
        console.error('Failed to mark as done:', error);
      }
    };

    const toggleShowArchived = () => {
      setShowArchived(!showArchived);
    };

    function submitLogout(e) {
      e.preventDefault().then(onLogout());
    }

    return (
      <div>
          <Navbar bg="dark" variant="dark" className='mb-4'>
          <Container>
              <Navbar.Text>
              <Button type="submit" variant="light" onClick={() => navigate(-1)}>Back</Button>
              </Navbar.Text>
              <Navbar.Brand className='ms-2'>Ordering system</Navbar.Brand>
              <Navbar.Collapse className="justify-content-end">
              <Navbar.Text>
                  <form onSubmit={e => submitLogout(e)}>
                  <Button type="submit" href="/logout" variant="light">Log out</Button>
                  </form>
              </Navbar.Text>
              </Navbar.Collapse>
          </Container>
          </Navbar>
          <Container>
          <h1 className='mb-4'>{showArchived ? 'Archived Invoices' : 'Kitchen Page'}</h1>
          <Row>
          {invoices.filter(invoice => invoice.archive_flag === showArchived).map(invoice => (
            <Col md={4} key={invoice.id} className="mb-3">
            <Card key={invoice.id} className="mb-3">
              <Card.Header>Invoice #{invoice.id}</Card.Header>
              <Card.Body>
                {orders.filter(order => order.invoice === invoice.id).map(order => {
                  const menu = menus.find(menu => menu.id === order.menu);
                  return (
                    <div key={order.id} className="d-flex justify-content-between align-items-center mb-2">
                      {menu ? menu.name : 'Unknown Menu'}
                      <div className="d-flex align-items-center">
                        <span className="text-muted me-2">{showArchived ? order.quantity : `${order.current_quantity}/${order.quantity}`}</span>
                        {!showArchived && (
                          <Button disabled={order.current_quantity <= 0} variant="danger" onClick={() => handleDecreaseQuantity(order)}>-</Button>
                        )}
                      </div>
                    </div>
                  );
                })}
                 {!showArchived && (
                <Button 
                  variant="success" 
                  disabled={!orders.filter(order => order.invoice === invoice.id).every(order => order.current_quantity === 0)} 
                  onClick={() => handleDone(invoice.id)}
                >Done
                </Button>
              )}
              </Card.Body>
            </Card>
            </Col>
          ))}
      </Row>
      <Button variant="link" onClick={toggleShowArchived}>
            {showArchived ? 'View Active Invoices' : 'View Archived Invoices'}
      </Button>
      </Container>
      </div>
    );
  };
  
  export default Kitchen;