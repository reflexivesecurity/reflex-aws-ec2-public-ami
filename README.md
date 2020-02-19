# reflex-aws-enforce-no-public-ami
A Reflex rule for enforcing that all AWS EC2 AMI's be kept private.

## Usage
To use this rule either add it to your `reflex.yaml` configuration file:  
```
version: 0.1

providers:
  - aws

measures:
  - reflex-aws-enforce-no-public-ami:
      email: "example@example.com"
```

or add it directly to your Terraform:  
```
...

module "enforce-no-public-ami" {
  source           = "github.com/cloudmitigator/reflex-aws-enforce-no-public-ami"
  email            = "example@example.com"
}

...
```

## License
This Reflex rule is made available under the MPL 2.0 license. For more information view the [LICENSE](https://github.com/cloudmitigator/reflex-aws-enforce-no-public-ami/blob/master/LICENSE)
