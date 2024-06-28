import './App.css';
import React, { useState, useEffect } from 'react';
import { useNavigate } from "react-router-dom";
import 'bootstrap/dist/css/bootstrap.css';
import { Container, Table, Button, Form, Modal, Navbar, Accordion } from 'react-bootstrap';
import client, { refreshTokenIfNeeded } from './Client';

const AdminPage = ({ onLogout }) => {
  const navigate = useNavigate();
  const [tables, setTables] = useState({});
  const [schemas, setSchemas] = useState({});
  const [relatedData, setRelatedData] = useState({ categories: [], menus: [], diningTables: [], invoices: [] });
  const [showModal, setShowModal] = useState(false);
  const [formData, setFormData] = useState({});
  const [newRecord, setNewRecord] = useState();
  const [currentTable, setCurrentTable] = useState('');
  const [error, setError] = useState(null);

  function submitLogout(e) {
    e.preventDefault().then(onLogout());
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
      const [categories, menus, diningTables, invoices] = await Promise.all([
        client.get('/api/categories/'),
        client.get('/api/menus/'),
        client.get('/api/dining-tables/'),
        client.get('/api/invoices/'),
      ]);
      setRelatedData({ categories: categories.data, menus: menus.data, diningTables: diningTables.data, invoices: invoices.data });
    } catch (error) {
      console.error('Failed to fetch related data:', error);
    }
  };

  const handleInputChange = (e) => {
    const target = e.target;
    const value = target.type === 'checkbox' ? target.checked : target.value; //boolean adaptation
    const name = target.name;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const formDataObj = new FormData(e.target);
    const { table, id } = formData;
    console.log(formData);

    try {
      if (newRecord) {
        await client.post(`/api/${table}/`, formDataObj);
      } else {
        await client.put(`/api/${table}/${id}/`, formDataObj);
      }
      setShowModal(false);
      fetchData(table);
      setFormData({});
      setError('');
    } catch (error) {
      setError('Failed to submit form, Check the fields again');
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
        await client.delete(`/api/${table}/${id}/`);
        fetchData(table);
      } catch (error) {
        console.error('Failed to delete item:', error);
      }
    }
  };

  useEffect(() => {
    const initialTables = ['categories', 'menus', 'dining-tables', 'orders', 'invoices'];
    initialTables.forEach(table => fetchData(table));
    fetchRelatedData();
  }, []);

  const renderTable = (tableName, items) => {
    const headers = items.data.length > 0 ? Object.keys(items.data[0]) : [];
    return (
      <Accordion.Item eventKey={tableName} key={tableName}>
        <Accordion.Header>{tableName}</Accordion.Header>
        <Accordion.Body>
          <Button onClick={() => handleNew(tableName)} className="mb-3">New</Button>
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
                    <td key={header}>{header == 'done_flag' || header == 'archive_flag' ? item[header] ? 'true' : 'false' : item[header]}</td>
                  ))}
                  <td>
                    <Button className="me-2" variant="warning" size="sm" onClick={() => handleEdit(tableName, item)}>Edit</Button>
                    <Button variant="danger" size="sm" onClick={() => handleDelete(tableName, item.id)}>Delete</Button>
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
            ) : field === 'invoice' && currentTable === 'orders' ? (
              <Form.Control
                as="select"
                name={field}
                value={formData[field] || ''}
                onChange={handleInputChange}
                required={schema[field].required}
                readOnly={schema[field].readOnly}
              >
                <option value="">Select {field}</option>
                {relatedData.invoices.map(option => (
                  <option key={option.id} value={option.id}>{option.id}</option>
                ))}
              </Form.Control>
            ) : field === 'table_id' && currentTable === 'invoices' ? (
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
                  <option key={option.id} value={option.id}>{option.location}</option>
                ))}
              </Form.Control>
            ) : schema[field].type === 'boolean' ? (
              <><Form.Check
                      type="checkbox"
                      name={field}
                      value='true'
                      onChange={handleInputChange}
                      {...console.log(formData)}
                      defaultChecked={formData[field] ? 'checked' : ''} /><Form.Check
                        type="hidden"
                        name={field}
                        value='false'
                        disabled={formData[field] ? 'checked' : ''} /></>
            ) : (
              <Form.Control
                type={schema[field].type === 'integer' ? 'number' : 'text'}
                name={field}
                value={formData[field] || ''}
                onChange={handleInputChange}
                required={schema[field].required}
                readOnly={schema[field].read_only}
              />
            ) }
          </Form.Group>
        ))}
        <Button type="submit" className="mt-3">{newRecord ? 'New' : 'Edit'}</Button>
      </Form>
    );
  };

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
        <h1 className='mb-4'>Admin Page</h1>
        <Accordion>
          {Object.entries(tables).sort(([a], [b]) => a.localeCompare(b, undefined, { sensitivity: 'base' })).map(([tableName, items]) => renderTable(tableName, items))}
        </Accordion>
      </Container>

      <Modal show={showModal} onHide={() =>{setShowModal(false);setError('');}}>
        <Modal.Header closeButton>
          <Modal.Title>{newRecord ? 'New' : 'Edit'}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {renderForm()}
          {error && <p style={{ color: 'red' }}>{error}</p>} {/* Display the error message */}
        </Modal.Body>
      </Modal>
    </div>
  );
};

export default AdminPage;