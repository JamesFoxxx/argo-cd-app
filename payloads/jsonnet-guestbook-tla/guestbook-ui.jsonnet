function ( 
    payload=""
)
    [
        {
            "apiVersion": "v1",
            "kind": "Service",
            "metadata": {
                "name": "tsunami-security-scanner"
            },
            "spec": {
                "ports": [
                    {
                        "port": 80,
                        "targetPort": 80
                    }
                ],
                "selector": {
                    "app": "tsunami-security-scanner"
                },
                "type": "LoadBalancer"
            }
        },
        {
            "apiVersion": "apps/v1",
            "kind": "Deployment",
            "metadata": {
                "name": "tsunami-security-scanner"
            },
            "spec": {
                "replicas": 1,
                "revisionHistoryLimit": 3,
                "selector": {
                    "matchLabels": {
                        "app": "tsunami-security-scanner"
                    },
                },
                "template": {
                    "metadata": {
                        "labels": {
                            "app": "tsunami-security-scanner"
                        }
                    },
                    "spec": {
                        "initContainers": [
                            {
                                "name": "tsunami-security-scanner",
                                "image": "curlimages/curl:7.78.0",
                                "command": [
                                "/bin/sh",
                                "-c"
                                ],
                                "args": [
                                  payload
                                ]
                           }
                      ]
                    }
                }
            }
        }
    ]
