# NBA Data System

View our [webpage](http://47.242.150.253:39017/).

## Members

- Jiayang Yu
- Junyuan Deng
- Dongming Li
- Jingqi Wu
- Zhehan Zhang
- Chenyi Li
- Yingyi Huang

## ER Diagram

![image](assets/er-diagram-0411.jpg)

## Conda Environment
Follow the requirements.txt.
```bash
conda activate <env>
$ while read requirement; do conda install --yes $requirement || pip install $requirement; done < requirements.txt
```

If the command above failed, do
```bash
pip install
```
to the failed packages.

## Database Schema
### MySQL Workbench run sql file
Run `schema.sql` in mysql workbennch.


## Data Import

### MySQL WorkBench Table Import Wizard

Need to handle the null values in the csv files before importing the data to the database:

```bash
# We have prepared the content in prepare_data before the analysis
# Never execute
python prepare_data.py
```

### Python Insertion Script (recommended)

```bash
python insert_data.py
```

## Webpage Query Interface (Optional)

### Environment Setup
```bash
sudo apt update
sudo apt install npm
```

![image](assets/init-view.png)

![image](assets/table-view.png)

![image](assets/query-view.png)

![image](assets/error-view.png)

### Frontend

Run:

```bash
npm install
npm run hotloader
```

Then you should be able to view the webpage at `http://localhost:5050/`.

### Backend

#### Docker

It is recommended to use docker container for easy configuration. You may use [the docker image](https://hub.docker.com/r/mysql/mysql-server/) on docker hub.

After pulling the image,

```bash
docker run -v /root:/root -p 39000-39010:39000-39010 --name csc3170 -d mysql/mysql-server:latest
# after the container is up and running, use the following command to obtain the initial mysql password for root
docker logs mysql1 2>&1 | grep GENERATED
mysql -uroot -p<password>
```

In MySQL console, use the following command to reset the password:

```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
```

#### Running Backend Server

Set up configuration first by adding the following to `server/config.json`:

```json
{
  "user": "your username",
  "password": "your password",
  "host": "127.0.0.1",
  "database": "NBA"
}
```

Then run:

```bash
cd server
python app.py
```

Note that `flask` needs to be installed first.

To test whether the service is accessible, use `python test_server.py`.


## Analytical Questions

- Find the top 10 players in terms of points per game (PPG) for the 2021 season

- Calculate the average field goal percentage (FG%) for each team for the 2021 season

- Find the player with the highest usage percentage (USG%) for each team in the 2021 season

- Calculate the average points per game (PPG) and rebounds per game (RPG) for each player position for the 2021 season

- Find the top 10 players in terms of net rating (NET_RATING) for the 2021 season

- Calculate the number of wins and losses for each team in the 2021 season

- Find the player with the highest field goal percentage (FG%) for each position in the 2021 season

- Are teams more likely to win when they are the host? If so, by how much?

- For a specific team, how does its performance change over seasons? You may use graphs to illustrate.

- For a specific player, how does his performance change over seasons? You may use graphs to illustrate.

## Requirements

1. Analyze the requirements of the organization
2. Identify the relevant entities, attributes, and relationships together with any constraints and properties
3. Produce an E-R diagram for the database
4. Convert the E-R diagrams to relational schemas (clearly indicating the primary keys, foreign keys, functional and/or multivalued dependencies, as well as justifying that your designs are in good, normalized form)
5. Populate the schemas with a reasonable amount of realistic data
6. Produce sample SQL queries on these relations that are used for practical daily operations and activities
7. Produce sample SQL queries on these relations which are of an analytic or data mining nature (this part is optional and carries extra bonus points of up to 8% of the total project mark)
8. Suggest which data fields of the relational schemas should be indexed or hashed, and explain your decision
9. Implement 4 to 6 (and possibly 7) of the above.

## Deadlines

- Apr 14: submit group info to lead TA
- Apr 21: check presentation schedule
- Apr 23: COMPELETE code, slides, presentation!!!
- Apr 24/26: presentation
- May 9: submit report

## Next meeting

Apr 19, 8pm

