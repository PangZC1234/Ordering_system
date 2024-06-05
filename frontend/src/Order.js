import './App.css';
import React, { useState, useEffect } from 'react';
import { useNavigate } from "react-router-dom";
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.css';
import { Container, Row, Col, Button, Modal, ListGroup, Navbar, Card, Form } from 'react-bootstrap';

axios.defaults.xsrfCookieName = 'csrftoken';
axios.defaults.xsrfHeaderName = 'X-CSRFToken';
axios.defaults.withCredentials = true;

const client = axios.create({
  baseURL: "http://localhost:8000",
  headers: {
    'Content-Type': 'application/json',
    'X-CSRFToken': document.cookie.match(/csrftoken=([^;]+)/)[1]
  },
  withCredentials: true
});

const Order = ({ onLogout }) => {
  const navigate = useNavigate();
  const [tables, setTables] = useState([]);
  const [showModal, setShowModal] = useState(false);
  const [categories, setCategories] = useState([]);
  const [menus, setMenus] = useState([]);
  const [selectedTable, setSelectedTable] = useState(null);
  const [selectedCategory, setSelectedCategory] = useState(1);
  const [cart, setCart] = useState([]);
  const [modalItem, setModalItem] = useState(null);
  const [tempQuantity, setTempQuantity] = useState(1);

    function submitLogout(e) {
      e.preventDefault();
      client.post(
        "/api/logout",
        {withCredentials: true}
      ).then(onLogout());
    }

    useEffect(() => {
      const fetchTables = async () => {
        const response = await client.get('/api/dining-tables/');
        setTables(response.data);
      };
  
      const fetchCategories = async () => {
        const response = await client.get('/api/categories/');
        setCategories(response.data);
      };
  
      const fetchMenus = async () => {
        const response = await client.get('/api/menus/');
        setMenus(response.data);
      };
  
      fetchTables();
      fetchCategories();
      fetchMenus();
    }, []);

    const handleAddToCart = (item, quantity) => {
      const existingItem = cart.find(cartItem => cartItem.id === item.id);
      if (existingItem) {
        setCart(cart.map(cartItem => 
          cartItem.id === item.id 
            ? { ...cartItem, quantity: cartItem.quantity + quantity } 
            : cartItem
        ));
      } else {
        setCart([...cart, { ...item, quantity }]);
      }
      setShowModal(false);
      setModalItem('');
      setTempQuantity(1);
    };
  
    const handleRemoveFromCart = (itemId) => {
      setCart(cart.filter(item => item.id !== itemId));
    };
  
    const handleChangeQuantity = (itemId, quantity) => {
      setCart(cart.map(item =>
        item.id === itemId 
          ? { ...item, quantity: item.quantity + quantity }
          : item
      ).filter(item => item.quantity > 0));
    };
  
  
    const handleCheckout = async () => {
      if (!selectedTable) {
        alert('Please select a table before checking out.');
        return;
      }
  
      try {
        cart.map(item => (client.post('/api/orders/',{ menu: item.id, quantity: item.quantity, table_id: selectedTable, done_flag: "false", archive_flag: "false"})))
        setCart([]);
        alert('Order placed successfully!');
      } catch (error) {
        console.error('Failed to place order:', error);
      }
    };
  
    const filteredMenus = selectedCategory 
      ? menus.filter(menu => menu.category === selectedCategory)
      : menus;

    const totalCartItems = cart.reduce((total, item) => total + item.quantity, 0);
  
    return (
      <><Navbar bg="dark" variant="dark">
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
      </Navbar><h1>Order Page</h1>
      <Container fluid>
      <Row>
        <Col md={2}>
          <Form.Group>
            <Form.Label>Select Table</Form.Label>
            <Form.Control 
              as="select" 
              value={selectedTable} 
              onChange={e => setSelectedTable(e.target.value)}
              required
            >
              <option value="">Select Table</option>
              {tables.map(table => (
                <option key={table.id} value={table.id}>Table {table.id}</option>
              ))}
            </Form.Control>
          </Form.Group>
          <ListGroup className="mt-3">
            {categories.map(category => (
              <ListGroup.Item 
                key={category.id}
                active={category.id === selectedCategory}
                onClick={() => setSelectedCategory(category.id)}
              >
                {category.name}
              </ListGroup.Item>
            ))}
          </ListGroup>
        </Col>
        <Col md={10}>
          <Row>
            {filteredMenus.map(menu => (
              <Col key={menu.id} md={3}>
                <Card onClick={() => { setModalItem(menu); setShowModal(true); }}>
                  <Card.Img variant="top" src={menu.picture_url} />
                  <Card.Body>
                    <Card.Title>{menu.name}</Card.Title>
                    <Card.Text>{menu.price}</Card.Text>
                  </Card.Body>
                </Card>
              </Col>
            ))}
          </Row>
        </Col>
      </Row>
      <Button 
        variant="primary" 
        className="mt-3"
        onClick={() => setShowModal(true)}
        disabled={cart.length === 0}
      >
        Cart ({totalCartItems})
      </Button>
      <Modal show={showModal} onHide={() => {setShowModal(false);setModalItem('');setTempQuantity(1)}}>
        <Modal.Header closeButton>
          <Modal.Title>{modalItem ? modalItem.name : 'Cart'}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {modalItem ? (
            <>
              <p>{modalItem.description}</p>
              <Button variant="outline-secondary" size="sm" onClick={() => tempQuantity > 1 ? setTempQuantity(tempQuantity - 1) : setTempQuantity(tempQuantity)}>-</Button>
              {tempQuantity}{console.log(tempQuantity)}
              <Button variant="outline-secondary" size="sm" onClick={() => tempQuantity < 50 ? setTempQuantity(tempQuantity + 1) : setTempQuantity(tempQuantity)}>+</Button>
              <Button onClick={() => handleAddToCart(modalItem,tempQuantity)}>Add to Cart</Button>
            </>
          ) : (
            <>
              <h5>Cart Items</h5>
              <ListGroup>
                {cart.map((item, index) => (
                  <ListGroup.Item key={index}>
                    {item.name} - {item.price} x {item.quantity}
                    <Button variant="outline-secondary" size="sm" onClick={() => handleChangeQuantity(item.id, -1)}>-</Button>
                    <Button variant="outline-secondary" size="sm" onClick={() => handleChangeQuantity(item.id, 1)}>+</Button>
                    <Button variant="danger" size="sm" onClick={() => handleRemoveFromCart(item.id)}>Delete</Button>
                  </ListGroup.Item>
                ))}
              </ListGroup>
              <Button variant="success" onClick={handleCheckout} disabled={cart.length === 0} className="mt-3">Checkout</Button>
            </>
          )}
        </Modal.Body>
      </Modal>
    </Container>
  </>
  );
};
  
  export default Order;