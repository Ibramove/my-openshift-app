# My OpenShift App

Ce projet montre comment déployer une application web sur OpenShift en utilisant un dépôt GitHub comme source pour une image Docker. Nous utilisons OpenShift pour automatiser la construction, le déploiement et la gestion des ressources.

## Prérequis

Avant de commencer, assurez-vous d'avoir les éléments suivants :

1. Un compte OpenShift avec accès au projet (ou espace de travail).
2. Un dépôt GitHub contenant le code source de l'application.
3. L'outil `oc` installé et configuré sur votre machine (outil de ligne de commande OpenShift).
4. Accès à un terminal avec les bonnes permissions pour exécuter les commandes.

## Étapes du projet

### 1. **Cloner le dépôt**

Commencez par cloner le dépôt GitHub de l'application sur votre machine locale.

```bash
git clone https://github.com/votre-utilisateur/my-openshift-app.git
cd my-openshift-app
```

### 2. **Configurer OpenShift**

Si vous n'avez pas encore un projet sur OpenShift, créez-en un. Vous pouvez le faire en ligne via l'interface web d'OpenShift ou via la ligne de commande.

```bash
oc new-project mon-projet
```

### 3. **Créer un BuildConfig**

Dans OpenShift, vous devez configurer un `BuildConfig` pour indiquer à OpenShift comment construire l'image Docker pour votre application à partir du dépôt GitHub. Utilisez la commande suivante pour créer un `BuildConfig` :

```bash
oc new-build --name=my-openshift-app-git --strategy=docker --binary=true
```

Cette commande crée un `BuildConfig` avec la stratégie Docker et vous permet de spécifier le code source en tant que source binaire.

### 4. **Construire l'image Docker**

Une fois que le `BuildConfig` est créé, vous devez télécharger le code source pour que OpenShift construise l'image Docker. Vous pouvez le faire avec la commande suivante :

```bash
oc start-build my-openshift-app-git --from-dir=. --follow
```

Cela démarre le processus de construction de l'image Docker. Si tout se passe bien, l'image sera construite et stockée dans OpenShift.

### 5. **Créer un Déploiement**

Une fois l'image construite, il est temps de créer un `DeploymentConfig` pour déployer l'application. Utilisez la commande suivante :

```bash
oc new-app my-openshift-app-git
```

Cela va créer un déploiement avec l'image que nous avons construite et démarrer les pods pour héberger l'application.

### 6. **Exposer l'Application avec une Route**

Une fois le déploiement effectué, nous devons exposer l'application au monde extérieur en créant une `Route`. Cela permet à l'application d'être accessible depuis un navigateur.

```bash
oc expose svc/my-openshift-app-git
```

Cela va créer une route avec un URL accessible. Vous pouvez obtenir l'URL de l'application avec la commande suivante :

```bash
oc get route
```

### 7. **Vérification**

Accédez à l'URL de la route générée pour voir si votre application est en cours d'exécution.

```bash
http://<route-url>.apps.openshift.example.com
```

### 8. **Mise à jour de l'Application**

Si vous apportez des modifications au code source dans votre dépôt GitHub, vous pouvez re-déployer l'application. Pour cela, il suffit de lancer un nouveau build et de redémarrer le déploiement :

```bash
oc start-build my-openshift-app-git --from-dir=. --follow
oc rollout restart deployment/my-openshift-app-git-00001-deployment
```

Cela redémarrera votre application avec la nouvelle version du code.

## Structure du Projet

Le projet a la structure suivante :

```
/my-openshift-app
├── Dockerfile         # Dockerfile pour construire l'image de l'application
├── server.js          # Fichier principal du serveur (Node.js)
├── package.json       # Dépendances de l'application
├── package-lock.json : # Dépendances de l'application
└── README.md          # Ce fichier
```

- **Dockerfile** : Ce fichier décrit comment construire l'image Docker de l'application.
- **server.js** : Le serveur de l'application qui écoute sur un port et sert le contenu de l'application.
- **package.json** : Fichier de configuration pour les dépendances de l'application.
- **package-lock.json** : Ce fichier est généré automatiquement lorsque les dépendances sont installées avec `npm`. Il verrouille les versions des dépendances pour garantir que les installations futures utilisent les mêmes versions.

## Dépannage

Si vous rencontrez des erreurs lors du déploiement, voici quelques étapes à suivre pour diagnostiquer et résoudre les problèmes :

1. **Vérifiez l'état des pods** :

   ```bash
   oc get pods
   ```

   Si les pods sont en état de `CrashLoopBackOff`, utilisez la commande suivante pour afficher les logs du pod et examiner les erreurs.

   ```bash
   oc logs <pod-name>
   ```

2. **Vérifiez les builds** :

   Si le build échoue, examinez les logs du build avec :

   ```bash
   oc logs build/my-openshift-app-git-<build-id>
   ```

   Cela vous aidera à comprendre pourquoi le build a échoué.

3. **Vérifiez les ressources** :

   Assurez-vous que toutes les ressources nécessaires (comme les services et les routes) sont créées correctement avec :

   ```bash
   oc get all
   ```

## Conclusion

Ce projet montre comment automatiser la construction, le déploiement et l'exposition d'une application Node.js sur OpenShift. En utilisant les commandes OpenShift, nous pouvons facilement déployer et gérer des applications dans un environnement cloud, tout en utilisant GitHub comme source pour nos applications.
```

### Explication  :

1. **Cloner le dépôt** : Expliquer comment cloner le projet depuis GitHub.
2. **Configurer OpenShift** : Créer un projet sur OpenShift.
3. **Créer un BuildConfig** : Comment configurer un `BuildConfig` pour construire l'image Docker.
4. **Construire l'image Docker** : Démarrer le processus de build avec OpenShift.
5. **Créer un Déploiement** : Déployer l'application sur OpenShift en utilisant le build précédent.
6. **Exposer l'Application avec une Route** : Exposer l'application pour qu'elle soit accessible depuis l'extérieur.
7. **Vérification** : Comment vérifier si l'application est en ligne.
8. **Mise à jour de l'Application** : Si le code est mis à jour, expliquer comment relancer le build et redémarrer l'application.
9. **Structure du Projet** : Fournir un aperçu de la structure du projet pour que les autres sachent où trouver les fichiers importants.
10. **Dépannage** : Donne des conseils utiles pour résoudre les problèmes courants.

