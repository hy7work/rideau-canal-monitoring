________________________________________

###   1. Introduction
The Rideau Canal Skateway is a key winter attraction in Ottawa, requiring continuous monitoring of ice conditions to ensure public safety. Traditional manual inspection methods are time-consuming and lack real-time responsiveness. This project presents a cloud-based solution that leverages Microsoft Azure services to provide real-time monitoring, analysis, and visualization of ice conditions across multiple locations.
The system integrates data streaming, processing, storage, and visualization components into a cohesive architecture. It enables stakeholders to make informed decisions based on up-to-date environmental conditions such as ice thickness, surface temperature, and snow accumulation.
________________________________________
###  2. System Architecture
The system follows a modern cloud-native architecture composed of five main components:
1.	Sensor Simulation – Generates real-time environmental data (e.g., temperature, ice thickness).
2.	Azure Stream Analytics – Processes streaming data and performs transformations.
3.	Azure Cosmos DB – Stores processed data in a scalable NoSQL database.
4.	Node.js Backend API – Retrieves and processes data for frontend consumption.
5.	Web Dashboard (Frontend) – Displays real-time conditions and trends visually.
###  Data Flow
1.	Sensor data is generated and sent to the cloud.
2.	Stream Analytics processes incoming data streams.
3.	Processed data is stored in Cosmos DB.
4.	The Node.js server queries Cosmos DB via REST APIs.
5.	The frontend dashboard displays real-time updates and historical trends.
This architecture ensures scalability, fault tolerance, and low-latency data processing.
________________________________________
###  3. Technologies Used
Component	Technology
Cloud Platform	Microsoft Azure
Stream Processing	Azure Stream Analytics
Database	Azure Cosmos DB
Backend	Node.js (Express)
Frontend	HTML, CSS, JavaScript
Data Format	JSON
Azure services provide high availability and scalability, making them suitable for real-time data applications.
________________________________________
###  4. Data Processing and Logic
4.1 Data Collection
Simulated sensors generate data including:
•	Ice thickness (cm)
•	Surface temperature (°C)
•	External temperature (°C)
•	Snow accumulation (cm)
•	Timestamp and location
4.2 Data Storage
Data is stored in Azure Cosmos DB using a partition key (/deviceId) to ensure efficient querying and scalability.
4.3 Backend Processing
The Node.js backend retrieves data from Cosmos DB and performs:
•	Filtering (latest data per location)
•	Sorting (time-series data for trends)
•	Transformation (mapping raw data to dashboard format)
4.4 Safety Classification Logic
The system determines safety status based on environmental conditions:
•	Safe: Ice thickness ≥ 30 cm and surface temperature ≤ -2°C
•	Caution: Ice thickness ≥ 25 cm and surface temperature ≤ 0°C
•	Unsafe: Otherwise
This classification helps users quickly assess whether skating conditions are safe.
________________________________________
###  5. Dashboard Features
The frontend dashboard provides a user-friendly interface with the following features:
5.1 System Status
Displays the overall safety status based on all monitored locations.
5.2 Current Conditions
Shows real-time data for:
•	Dow’s Lake
•	Fifth Avenue
•	NAC
Each location displays:
•	Ice thickness
•	Surface temperature
•	External temperature
•	Snow accumulation
•	Safety status
5.3 Trend Visualization
Charts display:
•	Average ice thickness over the last hour
•	Average surface temperature over time
These visualizations help identify patterns and changes in environmental conditions.
________________________________________
###  6. Challenges and Solutions
Challenge 1: Cosmos DB Partition Key Requirement
•	Issue: Container creation failed without a partition key
•	Solution: Defined /deviceId as partition key
Challenge 2: Query Compatibility
•	Issue: SQL syntax errors due to unsupported queries
•	Solution: Simplified queries and handled aggregation in backend
Challenge 3: Data Schema Mismatch
•	Issue: Backend expected aggregated data but received raw data
•	Solution: Transformed raw data in Node.js
Challenge 4: Environment Configuration
•	Issue: Missing environment variables caused connection failures
•	Solution: Configured .env file using dotenv
________________________________________
###  7. Results
The system successfully demonstrates:
•	Real-time data ingestion and processing
•	Cloud-based storage using Cosmos DB
•	RESTful API for data access
•	Interactive dashboard with live updates
•	Accurate safety classification
The final dashboard displays real-time ice conditions and trends, enabling effective monitoring of the Rideau Canal.
________________________________________
###  8. Conclusion
This project showcases the integration of cloud technologies to build a real-time monitoring system. By leveraging Azure Stream Analytics and Cosmos DB, the system efficiently processes and stores streaming data. The Node.js backend and web dashboard provide accessible and meaningful insights to users.
The solution is scalable, reliable, and suitable for real-world deployment in smart city and environmental monitoring applications.
________________________________________
###  9. Future Improvements
Potential enhancements include:
•	Integration with real IoT sensors
•	Alert system for unsafe conditions
•	Predictive analytics using machine learning
•	Mobile-friendly dashboard
•	Data caching for performance optimization
________________________________________
###  References
Microsoft Azure Documentation. (2026).
Azure Stream Analytics Documentation.
Azure Cosmos DB Documentation.
Node.js Official Documentation.
