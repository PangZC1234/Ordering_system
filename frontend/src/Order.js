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
  baseURL: "http://localhost:8000",
  headers: {
    'Content-Type': 'application/json',
    'X-CSRFToken': document.cookie.match(/csrftoken=([^;]+)/)[1]
  },
  withCredentials: true
});

const Order = ({ onLogout }) => {
  const navigate = useNavigate();
  const [tables, setTables] = useState({});
  const [schemas, setSchemas] = useState({});
  const [relatedData, setRelatedData] = useState({ categories: [], menus: [], diningTables: [] });
  const [showModal, setShowModal] = useState(false);
  const [formData, setFormData] = useState({});
  const [newRecord, setNewRecord] = useState();
  const [currentTable, setCurrentTable] = useState('');

    useEffect(() => {
    const initialTables = ['orders','menus'];
    initialTables.forEach(table => fetchData(table));
    }, []);

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

    const renderTable = (tableName, items) => {
    const headers = items.data.length > 0 ? Object.keys(items.data[0]) : [];
    return (
      <>
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
                <Button variant="danger" size="sm" onClick={() => handleDelete(tableName, item.id)}>Delete</Button>
              </td>
            </tr>
          ))}
        </tbody>
      </Table>
      </>
    );
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
          {Object.entries(tables).map(([tableName, items]) => renderTable(tableName, items))}
      </div>
    );
  };
  
  export default Order;