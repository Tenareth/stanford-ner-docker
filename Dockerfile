FROM java:8
MAINTAINER Keith Moore (keith.moore@epiqglobal.com)

RUN apt-get install -y \
      unzip \
    && apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

ADD http://nlp.stanford.edu/software/stanford-ner-2018-02-27.zip ner.zip
RUN unzip ner.zip

WORKDIR /stanford-ner-2018-02-27

ENV port=9000 classifierPath=classifiers/english.muc.7class.distsim.crf.ser.gz outputFormat=inlineXML

EXPOSE $port

CMD java -mx1000m -cp stanford-ner.jar:lib/* edu.stanford.nlp.ie.NERServer \
    -loadClassifier $classifierPath \
    -port $port -outputFormat $outputFormat

