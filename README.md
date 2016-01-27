# Trough

A document library for Pig.

## Installation

### Add and run the migrations

```
rake trough:install:migrations
rake db:migrate
```

### Add an intializer

config/intitializers/trough.rb

```
Trough.setup do |config|
  config.permission = ->(scope) { scope.can? :manage, ::Trough::Document }
  config.mount_path = 'documents'
end
```

### Set S3 Environment Variables

Add Figaro so can use dev env vars

```
gem 'figaro'
```

Create an application.yml file in /config with the S3 vars:

```
development:
  S3_ACCESS_KEY_ID: "xxx"
  S3_SECRET_ACCESS_KEY: "xxxx"
  S3_REGION: "eu-west-1"
  S3_BUCKET_NAME: "my-bucket"
```

## S3 config

### Edit the CORS Configuration on the bucket,:

```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <CORSRule>
        <AllowedOrigin>*</AllowedOrigin>
        <AllowedMethod>GET</AllowedMethod>
        <AllowedMethod>POST</AllowedMethod>
        <MaxAgeSeconds>3000</MaxAgeSeconds>
        <AllowedHeader>Authorization</AllowedHeader>
        <AllowedHeader>Content-Type</AllowedHeader>
        <AllowedHeader>Origin</AllowedHeader>
    </CORSRule>
</CORSConfiguration>

```

### Add a bucket policy

```
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket/store/*"
    }
  ]
}
```
