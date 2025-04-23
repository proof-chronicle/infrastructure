from diagrams import Cluster, Diagram
from diagrams.onprem.queue import RabbitMQ
from diagrams.onprem.database import MySQL
from diagrams.onprem.inmemory import Redis
from diagrams.programming.language import PHP, Go
from diagrams.onprem.network import Nginx
from diagrams.programming.language import Rust

with Diagram("Docker Compose Architecture", show=False, direction="LR"):
    with Cluster("Backend Services"):
        db = MySQL("MySQL (db)")
        redis = Redis("Redis")
        rabbitmq = RabbitMQ("RabbitMQ")

        with Cluster("Laravel App"):
            webapp = PHP("Laravel WebApp")
            webapp >> db
            webapp >> redis
            webapp >> rabbitmq

        indexer = Go("Content Indexer")
        indexer >> rabbitmq
        indexer >> db

    nginx = Nginx("NGINX")
    nginx >> webapp

    chainGateway = Rust("Chain Gateway")
    indexer >> chainGateway
    webapp >> chainGateway
