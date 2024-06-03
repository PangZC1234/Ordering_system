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

// Automatically add CSRF token to requests
client.interceptors.request.use(config => {
  const csrfToken = window.csrfToken;
  if (csrfToken) {
    config.headers['X-CSRFToken'] = csrfToken;
  }
  return config;
}, error => {
  return Promise.reject(error);
});

const AdminPage = ({ onLogout }) => {
  const navigate = useNavigate();
  const [tables, setTables] = useState({});
  const [schemas, setSchemas] = useState({});
  const [relatedData, setRelatedData] = useState({ categories: [], menus: [], diningTables: [] });
  const [showModal, setShowModal] = useState(false);
  const [formData, setFormData] = useState({});
  const [newRecord, setNewRecord] = useState();
  const [currentTable, setCurrentTable] = useState('');

  function submitLogout(e) {
    e.preventDefault();
    client.post(
      "/api/logout",
      {withCredentials: true}
    ).then(onLogout());
  }

  const fetchData = async (table) => {
    try {
      const [data, schema] = await Promise.all([
        client.get(`/api/${table}/`),
        client.options(`/api/${table}/`)
      ]);
      setTables(prevTables => ({ ...prevTables, [table]: { data: data.data, options: schema.data.actions.POST } }));
      setSchemas(prevSchemas => ({ ...prevSchemas, [table]: schema.data.actions.POST }));
    } catch (error) {
      console.error('Failed to fetch data:', error);
    }
  };

  const fetchRelatedData = async () => {
    try {
      const [categories, menus, diningTables] = await Promise.all([
        client.get('/api/categories/'),
        client.get('/api/menus/'),
        client.get('/api/dining-tables/'),
      ]);
      setRelatedData({ categories: categories.data, menus: menus.data, diningTables: diningTables.data });
    } catch (error) {
      console.error('Failed to fetch related data:', error);
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const formDataObj = new FormData(e.target);
    const { table, id } = formData;

    try {
      if (newRecord) {
        await client.post(`/api/${table}/`, formDataObj);
      } else {
        await client.patch(`/api/${table}/${id}/`, formDataObj);
      }
      setShowModal(false);
      fetchData(table);
      setFormData({});
    } catch (error) {
      console.error('Failed to submit form:', error);
    }
  };

  const handleEdit = (table, item) => {
    setFormData({ ...item, table });
    setCurrentTable(table);
    setShowModal(true);
    setNewRecord(false);
  };

  const handleNew = (table) => {
    setFormData({ table, id: null });
    setCurrentTable(table);
    setShowModal(true);
    setNewRecord(true);
  };

  const handleDelete = async (table, id) => {
    if (window.confirm('Are you sure you want to delete this item?')) {
      try {
        await client.post(`/api/${table}/${id}/delete/`);
        fetchData(table);
      } catch (error) {
        console.error('Failed to delete item:', error);
      }
    }
  };

  useEffect(() => {
    const initialTables = ['categories', 'menus', 'dining-tables', 'orders'];
    initialTables.forEach(table => fetchData(table));
    fetchRelatedData();
  }, []);

  const renderTable = (tableName, items) => {
    const headers = items.data.length > 0 ? Object.keys(items.data[0]) : [];
    return (
      <Accordion.Item eventKey={tableName} key={tableName}>
        <Accordion.Header>{tableName}</Accordion.Header>
        <Accordion.Body>
          <Button onClick={() => handleNew(tableName)}>New</Button>
          <Table striped bordered hover>
            <thead>
              <tr>
                {headers.map(header => (
                  <th key={header}>{header}</th>
                ))}
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {items.data.map(item => (
                <tr key={item[0]}>
                  {headers.map(header => (
                    <td key={header}>{item[header]}</td>
                  ))}
                  <td>
                    <Button variant="warning" size="sm" onClick={() => handleEdit(tableName, item)}>Edit</Button>
                    <Button variant="danger" size="sm" onClick={() => handleDelete(tableName, item)}{... console.log(item)}>Delete</Button>
                  </td>
                </tr>
              ))}
            </tbody>
          </Table>
        </Accordion.Body>
      </Accordion.Item>
    );
  };

  const renderForm = () => {
    const schema = schemas[currentTable] || {};
    return (
      <Form onSubmit={handleSubmit}>
        {Object.keys(schema).map(field => (
          <Form.Group key={field}>
            <Form.Label>{field}</Form.Label>
            {field === 'category' && currentTable === 'menus' ? (
              <Form.Control
                as="select"
                name={field}
                value={formData[field] || ''}
                onChange={handleInputChange}
                required={schema[field].required}
                readOnly={schema[field].readOnly}
              >
                <option value="">Select {field}</option>
                {relatedData.categories.map(option => (
                  <option key={option.id} value={option.id}>{option.name}</option>
                ))}
              </Form.Control>
            ) : field === 'menu' && currentTable === 'orders' ? (
              <Form.Control
                as="select"
                name={field}
                value={formData[field] || ''}
                onChange={handleInputChange}
                required={schema[field].required}
                readOnly={schema[field].readOnly}
              >
                <option value="">Select {field}</option>
                {relatedData.menus.map(option => (
                  <option key={option.id} value={option.id}>{option.name}</option>
                ))}
              </Form.Control>
            ) : field === 'table' && currentTable === 'orders' ? (
              <Form.Control
                as="select"
                name={field}
                value={formData[field] || ''}
                onChange={handleInputChange}
                required={schema[field].required}
                readOnly={schema[field].readOnly}
              >
                <option value="">Select {field}</option>
                {relatedData.diningTables.map(option => (
                  <option key={option.id} value={option.id}>{option.table_number}</option>
                ))}
              </Form.Control>
            ) : (
              <Form.Control
                type={schema[field].type === 'integer' ? 'number' : 'text'}
                name={field}
                value={formData[field] || ''}
                onChange={handleInputChange}
                required={schema[field].required}
                readOnly={schema[field].read_only}
              />
            )}
          </Form.Group>
        ))}
        <Button type="submit">{newRecord ? 'New' : 'Edit'}</Button>
      </Form>
    );
  };

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
        <h1>Admin Page</h1>
      <Accordion>
        {Object.entries(tables).map(([tableName, items]) => renderTable(tableName, items))}
      </Accordion>

      <Modal show={showModal} onHide={() => setShowModal(false)}>
        <Modal.Header closeButton>
          <Modal.Title>{newRecord ? 'New' : 'Edit'}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {renderForm()}
        </Modal.Body>
      </Modal>
    </div>
  );
};

export default AdminPage;