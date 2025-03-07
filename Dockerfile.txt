# Utilisation de l'image Node.js officielle
FROM node:18

# Définition du répertoire de travail
WORKDIR /app

# Copie des fichiers et installation des dépendances
COPY package.json package-lock.json ./
RUN npm install

# Copie du code source
COPY . .

# Exposition du port 8080
EXPOSE 8080

# Commande de démarrage
CMD ["node", "server.js"]
