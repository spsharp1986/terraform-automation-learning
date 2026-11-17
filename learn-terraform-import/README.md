# Import an existing Docker container

This learning snapshot is based on HashiCorp's Terraform import tutorial.
The upstream walkthrough is retained below with its original attribution.

## My exercise

- Worked with an existing nginx container and the kreuzwerker/docker provider.
- Used an import block targeting docker_container.web.
- Reviewed generated configuration and reduced it to container settings.
- Referenced docker_image.nginx.image_id instead of keeping a fixed local image ID.
- Configured host port 8081 to container port 80.

## Saved plan evidence

[Initial plan](../plan-reports/import-initial.json) and
[simplified configuration plan](../plan-reports/import-simplified.json) each
record a container import with an in-place update. The reports omit the
container ID and resource attribute values. They establish proposed changes;
they do not establish a successful apply or a running web response.

## Running a separate copy

This published copy uses a required container_id input in place of the local
container ID. Supply the ID of your own disposable existing container through
a local variable file or the CLI. The generated configuration has also had
its original container-ID comment removed.

Initialise and validate the configuration, then review a new plan. The provider
uses unix:///var/run/docker.sock, so the executing machine needs authorised
access to that Docker daemon. For HCP remote execution, that Unix socket
would have to exist on the actual runner. The published copy has no personal
HCP workspace binding.

The port binds on 0.0.0.0, which can expose the service on the host's interfaces.
Use an isolated lab and sample data. nginx:latest is a mutable image tag.

[Import blocks](https://developer.hashicorp.com/terraform/language/import) ·
[Generated configuration](https://developer.hashicorp.com/terraform/language/import/generating-configuration)

## Upstream tutorial walkthrough

The following retains the tutorial's CLI-import sequence and historical
examples. The current snapshot above uses an import block and generated.tf.

## Learn Terraform Import

Learn how to import existing resources under Terraform's management.

Follow along with the [Learn Terraform Import tutorial](https://developer.hashicorp.com/terraform/tutorials/state/state-import).

### Install prerequisites

1. Terraform: https://www.terraform.io/downloads.html
1. Docker: https://docs.docker.com/get-docker/

### Create a docker container

1. Run this docker command to create a container with the latest nginx image.

    ```shell
    docker run --name hashicorp-learn --detach --publish 8080:80 nginx:latest
    ```

1. Verify container is running by running `docker ps` or visiting `0.0.0.0:8080`
    in your web browser.

    ```shell
    docker ps --filter "name=hashicorp-learn"
    ```

### Import container resource

1. Initialize your workspace by running `terraform init`.

1. Add empty resource stub to `docker.tf` for the container.

    ```hcl
    resource "docker_container" "web" { }
    ```

1. Import the container into Terraform state.

    ```shell
    terraform import docker_container.web $(docker inspect -f {{.ID}} hashicorp-learn)
    ```

1. Now the container is in your terraform configuration's state.

    ```shell
    terraform show
    ```

1. Run `terraform plan`. Terraform shows errors for missing required arguments
    (`image`, `name`).

    ```shell
    terraform plan
    ```

1. Generate configuration and save it in `docker.tf`, replacing the empty
    resource created earlier.

    ```shell
    terraform show -no-color > docker.tf
    ```

1. Re-run `terraform plan`.
    ```shell
    terraform plan
    ```

1. Terraform will show warnings and errors about a deprecated attribute
    (`links`), and several read-only attributes (`ip_address`, `network_data`,
    `gateway`, `ip_prefix_length`, `id`). Remove these attributes from `docker.tf`.

1. Re-run `terraform plan`.

    ```shell
    terraform plan
    ```

    It should now execute successfully. The plan indicates that Terraform will
    update in place to add the `attach`, `logs`, `must_run`, and `start`
    attributes. Notice that the container resource will not be replaced.

1. Apply the changes. Remember to confirm the run with a `yes`.

    ```shell
    terraform apply
    ```

1. There are now several attributes in `docker.tf` that are unnecessary because
    they are the same as their default values. After removing these attributes,
    `docker.tf` will look something like the following.

    ```hcl
    # docker_container.web:
    resource "docker_container" "web" {
       name  = "hashicorp-learn"
       image = "sha256:9beeba249f3ee158d3e495a6ac25c5667ae2de8a43ac2a8bfd2bf687a58c06c9"

       ports {
           external = 8080
           internal = 80
       }
    }
    ```

1. Run `terraform plan` again to verify that removing these attributes did not
    change the configuration.

    ```shell
    terraform plan
    ```

### Verify that your infrastructure still works as expected

```shell
$ docker ps --filter "name=hashicorp-learn"
```

    You can revisit `0.0.0.0:8080` in your web browser to verify that it is
    still up. Also note the "Status" - the container has been up and running
    since it was created, so you know that it was not restarted when you
    imported it into Terraform.

### Create a Docker image resource

1. Retrieve the image's tag name by running the following command, replacing the
    sha256 value shown with the one from `docker.tf`.

    ```shell
    docker image inspect sha256:602e111c06b6934013578ad80554a074049c59441d9bcd963cb4a7feccede7a -f {{.RepoTags}}
    ```

1. Add the following configuration to your docker.tf file.

    ```hcl
    resource "docker_image" "nginx" {
      name = "nginx:latest"
    }
    ```

1. Run `terraform apply` to apply the changes. Remember to confirm the run with
    a `yes`.

    ```shell
    terraform apply
    ```

1. Now that Terraform has created a resource for the image, refer to it in
    `docker.tf` like so:

    ```hcl
    resource "docker_container" "web" {
      name  = "hashicorp-learn"
      image = docker_image.nginx.latest

    # File truncated...
    ```

1. Verify that your configuration matches the current state.

    ```shell
    terraform apply
    ```

### Manage the container with Terraform

1. In your `docker.tf` file, change the container's external port from `8080` to
    `8081`.

    ```hcl
    resource "docker_container" "web" {
      name  = "hashicorp-learn"
      image = "sha256:602e111c06b6934013578ad80554a074049c59441d9bcd963cb4a7feccede7a5"

      ports {
        external = 8081
        internal = 80
      }
    }
    ```

1. Apply the change. Remember to confirm the run with a `yes`.

    ```shell
    terraform apply
    ```

1. Verify that the new container works by running `docker ps` or visiting
    `0.0.0.0:8081` in your web browser.

    ```shell
    docker ps --filter "name=hashicorp-learn"
    ```

### Destroy resources

1. Run `terraform destroy` to destroy the container. Remember to confirm
    destruction with a `yes`.

    ```shell
    terraform destroy
    ```

1. Run `docker ps` to validate that the container was destroyed.

    ```shell
    docker ps --filter "name=hashicorp-learn"
    ```
