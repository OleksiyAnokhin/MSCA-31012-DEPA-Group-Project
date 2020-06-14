The repository for the group project **MSCA 31012 3 (Spring 2020) Data Engineering Platforms for Analytics**

Instructor: **Shree Bharadwaj**

Team: **MSCA Advisors**

![](https://i.ibb.co/ZVyJcCL/MSc-A-Advisors.png)

- _Chris Reimann_ [creimann@uchicago.edu](creimann@uchicago.edu)

- _Devanshi Verma_ [devanshi@uchicago.edu](devanshi@uchicago.edu)

- _Kyla Ronellenfitsch_ [kmr1@uchicago.edu](kmr1@uchicago.edu)

- _Oleksiy Anokhin_ [anokhin@uchicago.edu](anokhin@uchicago.edu)

**Executive summary:** The Chicago Transit Authority is a pillar of Chicago public life, completing over 450
million annual rides and employing more than 11 000 people. It has and must continue to be an
essential service for Chicagoans. The CTA is facing unprecedented challenges due to the economic fallout from COVID-19. Social distancing has necessitated a dramatically reduced ridership compared to previous
years. This has left the CTA far below their expected revenue, a trend which is expected
to continue in coming months. At the same time, organizations are encountering new and reinforced expectations of social
justice and fairness This should be a consideration when changing services. 

**We have constructed a data pipeline and minimal viable product** (which will allow
CTA to understand and respond to this new environment. We compiled essential data that will allow the CTA to appropriately allocate resources moving
forward, while considering both policy objectives and the shareholder expectations. The MVP of the database and analytical tool are built on zip code level analyses of bus and train ridership, socio economic indicators, COVID-19 cases, employment and public events We
have also provided suggestions for future iterations of this product.

**Project tools:**

![](https://i.ibb.co/P6gghsR/Tools.png)

**Project datasets:**

![](https://i.ibb.co/7S63mnY/Datasets.png)

**Example of exploratory analysis:**

![](https://i.ibb.co/BfFn4HJ/Exploratory-analysis.png)

**Database considerations**

![](https://i.ibb.co/bz9bwPx/DB-considerations.png)

**Dimensional model (OLAP)**

![](https://i.ibb.co/zJWQjmr/Dimensional-model.png)

**Example of analysis in Tableau**

![](https://i.ibb.co/pn98Qy8/Dashboard-example.png)

**Example of a predictive model, built with Prophet**

![](https://i.ibb.co/sRJ9GZ8/Prediction.png)

 <span style="color:red">**Instructions for working with the repository:**</span>

Dear Professor Bharadwaj!

For your convenience we summarized all important project files on GitHub and provide this description.

**Final slides (PDF format)** can be found in **Docs (Final presentation)** folder

**Links to all Tableau dashboards** can be found in **BI (Visualization)** folder

[CTA dashboard](https://bit.ly/transport-analysis)

[COVID-19 dashboard](https://bit.ly/covid19-chicago-analysis)

[Employment dashboard](https://bit.ly/employment-analysis)

[CTA Summary dashboard](https://bit.ly/cta-summary-analysis)

We intentionally did not put Tableau books for your convenience. You will see our names as authors of Tableau dashboards.

**Scripts (cleaning, db, prediction)** folder is the most informative folder

- **Cleaned data in csv format (examples)** provides examples of cleaned .csv files, which we used for the database work

- **CTA (buses, trains)** has scripts in R ad Python for cleaning data

- **CTA_TimeSeries** provides examples of time series analysis

- **Database management** contains the key information about all db work. Scripts include comments

- **Events, parks, COVID** has examples of data cleaning for these datasets

- **Google Mobility Data** contains the analysis of this dataset

- **Visualizing_Using Folium** – an example of data visualization, using this library

Respectfully, 

**MScA Advisors** (Chris, Devanshi, Kyla, Oleksiy)