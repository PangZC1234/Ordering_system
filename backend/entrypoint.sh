#!/bin/sh

# Function to generate a random password
generate_password() {
    tr -dc A-Za-z0-9 </dev/urandom | head -c 16
}

# Check if the database is ready
until python manage.py check --database default; do
  echo "Waiting for database to be ready..."
  sleep 2
done

# Run migrations and collect static files
python manage.py makemigrations
python manage.py migrate --no-input
python manage.py collectstatic --no-input

# Check if superuser exists
if python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.filter(is_superuser=True).exists())" | grep -q "False"; then
    echo "No superuser found. Creating one..."
    DJANGO_SUPERUSER_USERNAME=${DJANGO_SUPERUSER_USERNAME:-admin}
    DJANGO_SUPERUSER_EMAIL=${DJANGO_SUPERUSER_EMAIL:-admin@example.com}
    DJANGO_SUPERUSER_PASSWORD=$(generate_password)
    
    # Create superuser in Django shell
    if python manage.py shell <<EOF
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='$DJANGO_SUPERUSER_USERNAME').exists():
    User.objects.create_superuser('$DJANGO_SUPERUSER_USERNAME', '$DJANGO_SUPERUSER_EMAIL', '$DJANGO_SUPERUSER_PASSWORD')
    print('Superuser created successfully.')
else:
    print('Superuser already exists. Skipping creation.')
EOF
    then

    # Display superuser credentials
    echo "Username: $DJANGO_SUPERUSER_USERNAME"
    echo "Email: $DJANGO_SUPERUSER_EMAIL"
    echo "Password: $DJANGO_SUPERUSER_PASSWORD"
    echo "Please save these credentials securely. This is the only time the password will be displayed."
    else
        echo "error creating superuser."
    fi
else
    echo "Superuser already exists. Skipping creation."
fi


gunicorn backend.wsgi:application --bind 0.0.0.0:8000