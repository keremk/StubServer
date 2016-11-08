FROM perfectlysoft/ubuntu1510
RUN /usr/src/Perfect-Ubuntu/install_swift.sh --sure
RUN git clone https://github.com/keremk/StubServer.git /usr/src/StubServer
WORKDIR /usr/src/StubServer
RUN swift build
CMD .build/debug/StubServer --port 80
