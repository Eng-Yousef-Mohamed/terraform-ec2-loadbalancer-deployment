server {
    listen 80;
    server_name _;  # Use a variable for the server name

    location / {
        proxy_pass http://${load_balancer_dns}:80;  # Use a variable for the load balancer DNS name
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}