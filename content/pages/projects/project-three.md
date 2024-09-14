---
type: ProjectLayout
title: MAKING SENSE OF SEMI-STRUCTURED DATA USING MONGODB - A POLICY MAKER'S GUIDE
colors: colors-a
date: '2022-09-11'
client: ''
description: 'This Project was realised with my team mates, Ghislain FEPESSI AND EVELINE SOH'
addTitleSuffix: false
socialImage: /images/mongodb-logo-png.png
featuredImage:
  type: ImageBlock
  url: >-
    https://res.cloudinary.com/fulechib/image/upload/v1726156265/Purple_Gradient_Marketing_Analytics_Carousel_Instagram_Post_2_qzdndu.png
  altText: altText of the image
  caption: Caption of the image
  elementId: >-
    https://res.cloudinary.com/fulechib/image/upload/v1726156265/Purple_Gradient_Marketing_Analytics_Carousel_Instagram_Post_2_qzdndu.png
media:
  type: ImageBlock
  url: >-
    https://res.cloudinary.com/fulechib/image/upload/v1726156265/Purple_Gradient_Marketing_Analytics_Carousel_Instagram_Post_2_qzdndu.png
  altText: altText of the image
  caption: Caption of the image
  elementId: >-
    https://res.cloudinary.com/fulechib/image/upload/v1726156265/Purple_Gradient_Marketing_Analytics_Carousel_Instagram_Post_2_qzdndu.png
---
### Introduction

Every leader would agree that their greatest challenge is to design policies that satisfy everybody.

This is no different for the Parliament of India, who in September 2020 passed three farm acts that led to a farmer's protest.

During the pre-internet era, such a situation would be easily brought under control by meeting farmer's unions and leaders in the affected communities.

However, during the internet era, the situation easily spread like wild fire on the internet, making it difficult to manaage.

Without a clue about who's opinion is actually fuelling the uproar, it is difficult and even close to impossible for policy makers to control the situation since chances of having an effective dialogue are low.

Fortunately, with the right analysis of the data collected from Twitter (X) , it is possible to initiate dialogue with the right audience.

### About the Data

The data presents a 2020–2021 Indian farmers' protest by Farmer unions and their representatives, who  have demanded that the laws be repealed and have stated that they will not accept a compromise.

In the light of this protest, social media users have been very active in voicing their opinion about the matter.

The hashtag "#FarmersProtest" is very prevalent on Twitter, with thousands of users tweeting thousands of tweets with the hashtag.

The dataset consists of a JSON collection containing 139,999 documents about the tweets that have the hashtag "#FarmersProtest" (tweeted since February 1, 2021).

You may access the raw dataset here: [source](https://www.kaggle.com/datasets/prathamsharma123/farmers-protest-tweets-dataset-raw-json).

### Procedure

The dataset was uploaded into MongoDB Compass (a collection called protests.json was created) and was interesting queries were written via VS Code.

The "protests" collection is made up of 139,999 documents, 22 variables and several sub fields.

Table showing the variables and their corresponding data types:

| No. | Name of column  | Data Type         |
| --- | --------------- | ----------------- |
| 1   | url             | String            |
| 2   | date            | Date              |
| 3   | content         | String            |
| 4   | renderedContent | String            |
| 5   | \_id            | ObjectId          |
| 6   | user            | Object            |
| 7   | outlinks        | Array             |
| 8   | tcooutlinks     | Array             |
| 9   | replyCount      | Integer           |
| 10  | retweetCount    | Integer           |
| 11  | likeCount       | Integer           |
| 12  | quoteCount      | Integer           |
| 13  | conversationId  | Integer           |
| 14  | lang            | String            |
| 15  | source          | String            |
| 16  | sourceUrl       | String            |
|     |                 |                   |
| 17  | sourceLabel     | String            |
| 18  | media           | Array (Nullable)  |
| 19  | retweetedTweet  | Object (Nullable) |
| 20  | quotedTweet     | Object (Nullable) |
| 21  | mentionedUsers  | Array (Nullable)  |
| 22  | id              | Integer           |

The location information in the data was used to create a new collection named "geoLocation" that grouped cities into countries and countries into continents.

### Key Findings

1.  **Number of protesters in our database**

db.protests.aggregate(\[  {    $group: {      \_id: "$user.username"    }  },  {    $count: "uniqueUsernames"  }])

**Output**: 21,318

**2. The top 10 protesters who have the most retweets using the hashtag #FarmersProtest**

db.protests.aggregate(\[    { $match: { "content": { $regex: "#FarmersProtest", $options: "i" } } },    { $group: { \_id: "$user.username", tweet\_count: { $sum: 1 } } },    { $sort: { tweet\_count: -1 } },    { $limit: 10 }  ])

**Output**: harjot\_tweeting, tasveersandhu, rumsomal, rebelpacifist, shells\_n\_petals, jot\_\_b, with\_kaur, Jass\_k\_G, Iamjazzie96, and DigitalKisanBot

***

**3. The top 10 protesters with the highest number of followers on Twitter**

db.protests.aggregate(\[    {      $group: {        \_id: "$user.username",          totalFollowers: { $sum: "$user.followersCount" },         avgFollowers: { $avg: "$user.followersCount" }      }, { $sort: { retweetCount: -1 } },    }  ])

**Output**: ndtv, htTweets, IndiaToday, ZeeNewsEnglish, timesofindia, ABPNews, EconomicTimes, dna, bsindia and the\_hindu

**4. Top Hashtags Used Alongside #FarmersProtest**

db.protests.aggregate(\[    { $match: { "content": { $regex: "#FarmersProtest", $options: "i" } } },    { $unwind: "$content" },    { $group: { \_id: "$content", count: { $sum: 1 } } },    { $sort: { count: -1 } },    { $limit: 10 }  ])

**Output**: #ReleaseActivists #ReleaseFarmers #IStandWithFarmers #FarmersProtest #ReleaseFrStanSwamyNow #HathrasHorrorShocksIndia #DelhiRiots2020 #ReleaseActivists #ModiAgainstFarmers #300DeathsAtProtest

**5. Top 5 Countries with the highest number of tweets**

db.protests.aggregate(\[    {      $lookup: {        from: "geoLocation",        let: { userLocation: { $toLower: "$user.location" } },        pipeline: \[          {            $unwind: "$cities\_countries"          },          {            $match: {              $expr: {                $eq: \[{ $toLower: "$cities\_countries.City" }, "$$userLocation"]              }            }          }        ],        as: "location\_data"      }    },    {      $unwind: "$location\_data"    },    {      $group: {        \_id: "$location\_data.cities\_countries.Country",        tweetCount: { $sum: 1 }      }    },    {      $sort: { tweetCount: -1 }    }  ])

**Output**: Unknown: 65571, India: 25915, Canada: 10,185, United Kingdom: 1747 and Australia: 1209

**6. Number of retweets according to continent and the corresponding number of protesters involved**

db.protests.aggregate(\[  {        $lookup: {      from: "geoLocation",      localField: "user.location",      foreignField: "cities\_countries.City",      as: "location\_info"    }  },  {       $unwind: "$location\_info"  },  {        $group: {      \_id: "$location\_info.continent",              numRetweets: { $sum: "$retweetCount" },       numberIDs: { $sum: 1 }                      }  },  {        $sort: { numRetweets: -1 }  }])

**Output in (numRetweets, numIDs) pairs**: Unknown (336520, 65416), Asia: (322126, 19174), North America (43847, 10177), Oceania (11659, 1209) and Europe (6503, 1860).

### Observations and Recommendations

Although the farmer's Act that was passed in India was expected to affect only the Indian farmers, many other people around the world took interest in the situation, with Canada  being the second biggest country leading the protest online after India.

Even though large media houses such as ndTV, ZeeNewsEnglish and timesofindia, just to name a few, actively participated in propagating the news around the farmer's protest in India, their opinions were not as appreciated by the public like those of individual protesters like harjot\_tweeting and tasveersandhu.

Although the hashtag #FarmersProtest was the main hashtag used in the study, protesters used other hashtags like #ReleaseActivists and #ReleaseFarmers. The hashtags in themselves reveal more information about the ongoing protest, notably, that protesters were being arrested.

Based on the analyses above, here are a few recommendations to policy makers:

*   putting the scope of them protest in perspective is a smart move, as the opinion of activists around the world has a great influence on the farmers and the protesters in India.

*   identifying the influencers and initiating dialogue with them will help save time and effort, since they can relate with other farmers more.

*   understnading the ramifications of the protest by following associated hashtags should facilitate target topics of discussion by the policy makers.

###

### Limitations of the Project

The project faced several limitations, including data quality issues such as null or empty values in fields like media, outlinks, quotedTweet, and mentionedUsers.

Case sensitivity in textual data and the complexity of fields like content and renderedContent required additional processing. Inconsistencies in city names led to 65,571 "unknown" locations, limiting geographical insights.

Many user accounts were anonymous or lacked sufficient metadata, affecting influencer identification.

The dataset covered a limited time period (February 2021), restricting long-term trend analysis. Biases inherent in social media data may have skewed results toward more vocal groups, excluding underrepresented voices like farmers who are less active online. Additionally, while hashtags were analyzed, conversations outside those specific hashtags may have been missed. These limitations impact the overall accuracy and depth of the analysis.

To address these limitations, future work should improve data cleaning, standardize text and location fields, expand the dataset's timeframe, and incorporate other data sources to reduce bias. Additionally, enhancing language processing and employing advanced methods to identify hidden influencers and conversations would yield more accurate insights.

###

### Conclusion

In conclusion, this project highlights the power of social media in shaping and amplifying public opinion, particularly in complex socio-political issues like the Indian farmers' protest. The data reveals that the protest extended far beyond India's borders, influencing activists and citizens globally. By
analyzing key influencers, hashtags, and geographical trends, policy makers can gain valuable insights into the scope and nature of the movement. Leveraging such data-driven approaches allows for more effective, targeted communication and engagement, ensuring that dialogue is initiated with the right voices and concerns are addressed efficiently. This approach not only enhances decision-making but also fosters a more inclusive and informed policy-making process.
