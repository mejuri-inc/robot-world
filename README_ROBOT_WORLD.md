## Requirements

* Docker
* Ruby version 2.5.0 or later
* Rails version 6.0.0 or later


## Instalation

### 1. Run database

```
docker-compose up
```

You can access a database client here: http://localhost:8080

```
server: robots-database
database: robocop
username: alex
password: murphy
```
### 2. Install dependencies
```
bundle install
```

### 3. Run migrations
```
rails db:migrate
```
### 4. Start applicacion
```
rails s
```
### 5. Run Task: Robots & Statistic
```
whenever --update-crontab --set environment='development'
```
You can see the logs in ./log/cron.log





# Run test
```
rspec --format doc
```
# Enpoints

There are endpoints available that allow you to interact with Robot World

### Change an Order

It allows to generate an order change

```bash
POST /order/:orderId/changes/:model
```

Request Example

```bash
curl -X POST -H 'Content-Type: application/json' http://localhost:3000/order/1/changes/M4
```

Response Example

```json
{
  "id": 4,
  "price": "2925.0",
  "cost": "2250.0",
  "model": "M4",
  "year": 2021,
  "assembly_line": "Completed",
  "created_at": "2021-06-25T18:58:03.888Z",
  "updated_at": "2021-06-25T18:58:03.991Z"
}
```

### Get a Car

It allows to retrieve the car information

```bash
GET /car/:carId
```

Request Example

```bash
curl -X GET http://localhost:3000/car/3
```

Response Example

```json
{
  "id": 3,
  "price": "2099.5",
  "cost": "1615.0",
  "model": "Brabus",
  "year": 2021,
  "assembly_line": "Completed",
  "created_at": "2021-06-25T21:17:04.680Z",
  "updated_at": "2021-06-25T21:17:04.763Z"
}
```

### Get Statistic

It allows to retrieve the daily statistics

```bash
GET /statistic
```

Request Example

```bash
curl -X GET http://localhost:3000/statistic
``` 
Response Example

```json
{
  "total_sold": 30,
  "total_price": "12615.2",
  "revenues": "2911.2",
  "average_order_value": "3153.8",
  "detail": {
    "store": {
      "total": 18,
      "details": {
        "Model 05": 4,
        "Model 03": 4,
        "Model 09": 1,
        "Model 08": 1,
        "Model 10": 3,
        "Model 02": 2,
        "Model 04": 3
      }
    },
    "defective": {
      "total": 1,
      "details": {
        "Model 09": 1
      }
    },
    "sold": {
      "total": 4,
      "details": {
        "Model 08": 2,
        "Model 01": 1,
        "Model 04": 1
      }
    },
    "warehouse": {
      "total": 7,
      "details": {
        "Model 08": 1,
        "Model 04": 2,
        "Model 10": 1,
        "Model 09": 1,
        "Model 07": 2
      }
    }
  }

```

It is also possible to see the statistics in the log file: ./log/cron.log

```code
Statistic
 - Total Cars ................... 30
 - Defective Cars  .............. 1 => [M5,1]
 - Warehouse Cars  .............. 10 => [M5,2] [M1,1] [M7,2] [M3,1] [M2,1] [M4,1] [M8,2]
 - Stock Cars  .................. 16 => [M2,1] [M7,3] [M10,1] [M9,5] [M3,2] [M8,1] [M6,2] [M1,1]
 - Sold Cars  ................... 3 => [M1,2] [M10,1]
 - Revenues ..................... 2240.4
 - Average Order Value .......... 3236.13

```