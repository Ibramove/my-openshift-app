FROM node:18

WORKDIR /app

# Copier package.json et package-lock.json (si existe)
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste du code de l'application
COPY . .

# Exposer le port sur lequel l'application fonctionne
EXPOSE 8080

# Lancer l'application
CMD ["node", "server.js"]
