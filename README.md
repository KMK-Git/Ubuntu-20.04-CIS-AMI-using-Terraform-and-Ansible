<!-- PROJECT LOGO -->
<br />
<p align="center">

  <h3 align="center">Ubuntu-20.04-CIS-AMI-using-Terraform-and-Ansible</h3>

  <p align="center">
    Create Ubuntu 20.04 AMI hardened according to CIS benchmarks using Terraform and Ansible
    <br />
    <a href="https://github.com/KMK-Git/Ubuntu-20.04-CIS-AMI-using-Terraform-and-Ansible/issues">Report Bug</a>
    ·
    <a href="https://github.com/KMK-Git/Ubuntu-20.04-CIS-AMI-using-Terraform-and-Ansible/issues">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li><a href="#read-before-using-this-repository">Read before using this repository</a></li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

![Architecture](../assets/assets/Architecture.png?raw=true)

This repository is used to create an Amazon Machine Image (AMI) for Ubuntu 20.04 which is hardened according to CIS benchmarks. It uses the [Ansible role](https://github.com/alivx/CIS-Ubuntu-20.04-Ansible) created by [Alivx](https://github.com/alivx) for creating the image.

### Built With

- [Terraform](https://www.terraform.io/)
- [Ansible](https://www.ansible.com/)
- [GitHub Actions](https://github.com/features/actions)

## Read before using this repository

- This repository will create billable AWS resources.
- The Ansible role used does not cover all parts of the CIS benchmarks. Please refer to [CIS-Ubuntu-20.04-Ansible repository](https://github.com/alivx/CIS-Ubuntu-20.04-Ansible#table-of-roles) for more information on which guidelines are covered. In order to make manual changes to the image, you can run the "Ubuntu 20.04 CIS AMI Baker" workflow in two parts. For the first run set create_instance_and_deploy_ansible=yes and create_ami_and_destroy_instance=no. Connect to the instance using Session Manager and make any manual changes. For the second run set create_instance_and_deploy_ansible=no and create_ami_and_destroy_instance=yes.

<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

* AWS account
* [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

### Using this Repository

1. Create an IAM User with programmatic access AWS Access Key ID and Secret Access Key. Attach [this IAM policy](documentation/IAMPolicy.json) to the user. Replace placeholder values like STATE_BUCKET_NAME with actual values.
2. Create your own copy of the repository on GitHub by cloning or forking.
3. Set your repository secrets according to the table given at [documentation/SECRETS.md](documentation/SECRETS.md).
4. Replace [ansible/roles/cisubuntu/default/main.yml](ansible/roles/cisubuntu/default/main.yml) with contents of [ansible/roles/cisubuntu/default/main-example.yml](ansible/roles/cisubuntu/default/main-example.yml). Run ansible-vault encrypt to encrypt the modified main.yml file. Set the vault password you used as the value of VAULT_PASS GitHub secret.
5. Push to your repository.
6. Run the 'Ubuntu 20.04 CIS AMI Baker' workflow.

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/KMK-Git/Ubuntu-20.04-CIS-AMI-using-Terraform-and-Ansible/issues) for a list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License

Distributed under the GNU GPL-3.0 License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Project Link: [https://github.com/KMK-Git/Ubuntu-20.04-CIS-AMI-using-Terraform-and-Ansible](https://github.com/KMK-Git/Ubuntu-20.04-CIS-AMI-using-Terraform-and-Ansible)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [CIS-Ubuntu-20.04-Ansible](https://github.com/alivx/CIS-Ubuntu-20.04-Ansible)
* [Best-README-Template](https://github.com/othneildrew/Best-README-Template)
