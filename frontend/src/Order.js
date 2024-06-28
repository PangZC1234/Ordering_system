import './App.css';
import React, { useState, useEffect } from 'react';
import { useNavigate } from "react-router-dom";
import 'bootstrap/dist/css/bootstrap.css';
import { Container, Row, Col, Button, Modal, ListGroup, Navbar, Card, Form } from 'react-bootstrap';
import client, { refreshTokenIfNeeded } from './Client';

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
      e.preventDefault().then(onLogout());
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
        // Step 1: Create a new Invoice
        const invoiceResponse = await client.post('/api/invoices/', { table_id: selectedTable, archive_flag: 'false'});
        const invoiceId = invoiceResponse.data.id;

        // Step 2: Create OrderItem entries for each cart item
        const orderPromises = cart.map(item =>
          client.post('/api/orders/', { 
            invoice: invoiceId, 
            menu: item.id, 
            quantity: item.quantity,
            current_quantity: item.quantity
          })
        );

        // Wait for all orders to be placed
        await Promise.all(orderPromises);

        // Clear the cart and notify the user
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

    const calculateTotal = () => {
      return cart.reduce((total, item) => total + item.price * item.quantity, 0);
    }
  
    return (
      <div>
        <Navbar bg="dark" variant="dark" className='mb-4'>
        <Container className="d-flex justify-content-between">
          <Button type="submit" variant="light" onClick={() => navigate(-1)}>Back</Button>
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
      <Container fluid>
      <h1 className='mb-4'>Order Page</h1>
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
      <Modal show={showModal} onHide={() => {setShowModal(false);}} onExited={() => {setModalItem('');setTempQuantity(1)}}>
        <Modal.Header closeButton>
          <Modal.Title>{modalItem ? modalItem.name : 'Cart'}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {modalItem ? (
            <>
            <p>{modalItem.description}</p>
            <div className="d-flex justify-content-between align-items-center mb-2">
              <div className="d-flex align-items-center">
                  <Button className="me-2" variant="outline-secondary" size="sm" onClick={() => tempQuantity > 1 ? setTempQuantity(tempQuantity - 1) : setTempQuantity(tempQuantity)}>-</Button>
                  {tempQuantity}
                  <Button className="ms-2" variant="outline-secondary" size="sm" onClick={() => tempQuantity < 50 ? setTempQuantity(tempQuantity + 1) : setTempQuantity(tempQuantity)}>+</Button>
              </div>
                  <Button className="ms-3 justify-content-end" onClick={() => handleAddToCart(modalItem, tempQuantity)}>Add to Cart</Button>
            </div>
            </>
          ) : (
            <>
              <h5>Cart Items</h5>
              <ListGroup>
                {cart.map((item, index) => (
                  <ListGroup.Item key={index} className="d-flex justify-content-between align-items-center mb-2">
                    <div className="d-flex align-items-center">
                      {item.name} 
                    </div>
                    <div className="d-flex align-items-center">
                    {item.price} x {item.quantity}
                    <Button className="m-2" variant="outline-secondary" size="sm" onClick={() => handleChangeQuantity(item.id, -1)}>-</Button>
                    <Button variant="outline-secondary" size="sm" onClick={() => handleChangeQuantity(item.id, 1)}>+</Button>
                    <Button className="ms-2" variant="danger" size="sm" onClick={() => handleRemoveFromCart(item.id)}>Delete</Button>
                    </div>
                  </ListGroup.Item>
                ))}
              </ListGroup>
              <div className="d-flex justify-content-between align-items-center mt-3">
                <h6>Total Amount: {calculateTotal().toFixed(2)}</h6>
                <Button variant="success" onClick={handleCheckout} disabled={cart.length === 0}>Checkout</Button>
              </div>
            </>
          )}
        </Modal.Body>
      </Modal>
    </Container>
  </div>
  );
};
  
  export default Order;