from kafka import KafkaProducer
from kafka.errors import KafkaError

producer = KafkaProducer()
# future = producer.send('test', b'aabb')

producer.send('test', key=b'foo', value=b'bar')

