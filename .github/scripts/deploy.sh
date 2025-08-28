name: Deploy to EC2

# Trigger deployment when you push to master
on:
  push:
    branches:
      - master

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # 1️⃣ Checkout your repository
      - name: Checkout code
        uses: actions/checkout@v3

      # 2️⃣ Setup SSH agent with your private key stored in GitHub secrets
      - name: Setup SSH agent
        uses: webfactory/ssh-agent@v0.7.0
        with:
          ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}

      # 3️⃣ Deploy to your EC2 server
      - name: Deploy to EC2
        run: |
          echo "Starting deployment to EC2..."
          ssh -o StrictHostKeyChecking=no ${{ secrets.EC2_USER }}@${{ secrets.EC2_HOST }} \
            "docker pull your-docker-username/the-button:latest && docker-compose -f /path/to/docker-compose.yml up -d"
