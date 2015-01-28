# docker-hyperdex-ycsb

**Hyperdex from sources with Yahoo! Cloud Serving Benchmark on board.**

### To start container:
        docker run -it --name=ycsb --net=host umatomba/docker-hyperdex-ycsb:1.6

### Ycsb load example:
        java -Djava.library.path=/usr/local/lib/ com.yahoo.ycsb.Client -load -db org.hyperdex.ycsb.HyperDex -P /hyperdex_build/ycsb-0.1.4/workloads/workloada -p "hyperdex.host=192.168.100.1" -p "hyperdex.port=1982" -p theads=16

### Ycsb start example:
        java -Djava.library.path=/usr/local/lib/ com.yahoo.ycsb.Client -t -db org.hyperdex.ycsb.HyperDex -P /hyperdex_build/ycsb-0.1.4/workloads/workloada -p theads=16 -p "hyperdex.host=192.168.100.1" -p "hyperdex.port=1982"


### Note 1: For the tests the space must be created manually.
- Start hyperdex client:
docker run -it --name=hyperdex-client umatomba/hyperdex-client python2.7
- Connect with hyperdex:
                a = hyperdex.admin.Admin('192.168.100.1', 1982)
- Run:
```
a.add_space('''
space usertable
key k
attributes field0, field1, field2, field3, field4,
                   field5, field6, field7, field8, field9
create 24 partitions
tolerate 1 failure
  ''')
```

### Note 2: The docker hyperdex image: 
umatomba/docker-hyperdex:1.6

