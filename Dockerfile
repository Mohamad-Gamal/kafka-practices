version: '2'
services:
  ed-pyspark-jupyter:
    image: jupyter/pyspark-notebook:spark-3.3.0
    user: root
    container_name: ed-pyspark-jupyter-lab
    ports:
      - 8888:8888
      - 4040:4040
    environment:
      JUPYTER_PORT: 8888
      SPARK_UI_PORT: 4040
      GRANT_SUDO: yes
    volumes:
      - streaming_data:/data:rw

  ed-zookeeper:
    image: confluentinc/cp-zookeeper:latest
    container_name: ed-zookeeper
    ports:
      - 2181:2181
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_TICK_TIME: 2000

  ed-kafka:
    image: confluentinc/cp-kafka:latest
    container_name: ed-kafka
    depends_on:
      - ed-zookeeper
    ports:
      - 9092:9092
    volumes:
      - streaming_data:/data:rw
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: ed-zookeeper:2181
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://ed-kafka:29092,PLAINTEXT_HOST://127.0.0.1:9092
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT
      KAFKA_INTER_BROKER_LISTENER_NAME: PLAINTEXT
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
      KAFKA_CREATE_TOPICS: "raw:1:1"

volumes:
  streaming_data:
