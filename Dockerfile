FROM golang:1.21.1-alpine as build

# Set destination for COPY
WORKDIR /app

# Download Go modules
COPY go.mod ./
RUN go mod download

# Copy the source code
COPY main.go ./

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /hello


FROM scratch

# Set working directory
WORKDIR /app

# Copy built binary application from 'build' image
COPY --from=build /hello .

# Run
CMD ["/app/hello"]