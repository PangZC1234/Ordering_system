from django.test import TestCase
from django.contrib.auth import get_user_model
from .models import Category, Menu, DiningTable, Invoice, Order

class ModelsTestCase(TestCase):
    
    def setUp(self):
        self.user = get_user_model().objects.create_user(
            username="testuser",
            email="testuser@example.com",
            password="testpass123"
        )
        self.category = Category.objects.create(name="Beverages")
        self.menu = Menu.objects.create(
            name="Coffee",
            description="A hot beverage",
            category=self.category,
            price=2.50,
            picture_url="http://example.com/coffee.jpg"
        )
        self.table = DiningTable.objects.create(
            capacity=4,
            location="Near window"
        )
        self.invoice = Invoice.objects.create(
            table_id=self.table,
            archive_flag=False
        )
        self.order = Order.objects.create(
            invoice=self.invoice,
            menu=self.menu,
            quantity=2,
            current_quantity=2
        )

    def test_create_user(self):
        user = get_user_model().objects.get(email="testuser@example.com")
        self.assertEqual(user.username, "testuser")
        self.assertTrue(user.check_password("testpass123"))

    def test_create_category(self):
        category = Category.objects.get(name="Beverages")
        self.assertEqual(category.name, "Beverages")

    def test_create_menu(self):
        menu = Menu.objects.get(name="Coffee")
        self.assertEqual(menu.description, "A hot beverage")
        self.assertEqual(menu.category, self.category)
        self.assertEqual(menu.price, 2.50)
        self.assertEqual(menu.picture_url, "http://example.com/coffee.jpg")

    def test_create_dining_table(self):
        table = DiningTable.objects.get(location="Near window")
        self.assertEqual(table.capacity, 4)
        self.assertEqual(table.location, "Near window")

    def test_create_invoice(self):
        invoice = Invoice.objects.get(id=self.invoice.id)
        self.assertEqual(invoice.table_id, self.table)
        self.assertFalse(invoice.archive_flag)

    def test_create_order(self):
        order = Order.objects.get(id=self.order.id)
        self.assertEqual(order.invoice, self.invoice)
        self.assertEqual(order.menu, self.menu)
        self.assertEqual(order.quantity, 2)
        self.assertEqual(order.current_quantity, 2)

if __name__ == "__main__":
    TestCase.main()
