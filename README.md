# Mapproxy Deployment

In this repo you will find everything you need in order to deploy [Mapproxy](https://mapproxy.github.io/mapproxy/latest/index.html) on `Openshift`.

## Configuring Mapproxy

Edit the `mapproxy.yaml` file under `helm/config/mapproxy.yaml` in order to serve your geographical data (see [configuring mapproxy](https://mapproxy.github.io/mapproxy/latest/configuration.html#mapproxy-yaml)).

> [!Note]
> In the given `mapproxy.yaml` file there are two grids defined for your use that are compliant to our used grids in our production environments.

## Getting the image

First of all, we need to create our `image`:

```bash
docker build --rm -t <YOUR_REPOSITORY>/mapproxy:v1.13.2 .
```

Now we push the image to our repository:

```bash
docker push <YOUR_REPOSITORY>/mapproxy:v1.13.2
```

## Running Mapproxy with docker

To run `Mapproxy` with docker read more at [kartoza/docker-mapproxy](https://github.com/kartoza/docker-mapproxy/tree/master?tab=readme-ov-file#running-mapproxy).

## Helm Deployment

### Getting the deployment ready

Replace all of the following in the `values.yaml` file with your wanted values:

1. `<YOUR_REPOSITORY>` - repositories url (used only if YOUR_MAPPROXY_REPOSITORY isn't defined)
2. `<YOUR_REGISTRY>` - registry name (used only if YOUR_MAPPROXY_REGISTRY isn't defined)
3. `<YOUR_MAPPROXY_REPOSITORY>` - mapproxy repositories url
4. `<YOUR_MAPPROXY_REGISTRY>` - mapproxy registry name
5. `<YOUR_TAG>` - mapproxy image tag
6. `<YOUR_PULL_SECRET>` - secret name containing the repositories authentication information

Go over all of the values and change them according to what suites your needs.

Important values to notice:

1. `enabled` - to enable or disable different parts of the deployment
2. `replicaCount` - sets the amount of pods for each deployment
3. `resources` - define the resources for each deployment

### Deploying to a Kubernetes cluster

Enter the `helm` folder:

```bash
cd helm
```

First you should check that everything is configured correctly and your chart is valid:

```bash
helm install --dry-run <WANTED_DEPLOYMENT_NAME> .
```

If there are no errors we can deploy our chart:

```bash
helm install <WANTED_DEPLOYMENT_NAME> .
```

### Validate the deployment

1. Make sure all of the pods are up and running
2. Try to navigate to `<YOUR_ROUTE>/api/wmts/1.0.0/WMTSCapabilities.xml`, if you receive a valid `xml` of `wmts` capabilities then the deployment is valid
3. If not, look at the `nginx` and `Mapproxy` pod logs to start debugging the issue
