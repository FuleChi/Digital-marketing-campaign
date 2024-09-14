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



Key Findings

1.  The top 10 users who have tweeted the most using the hashtag #FarmersProtest

db.protests.aggregate(\[    { $match: { "content": { $regex: "#FarmersProtest", $options: "i" } } },    { $group: { \_id: "$user.username", tweet\_count: { $sum: 1 } } },    { $sort: { tweet\_count: -1 } },    { $limit: 10 }  ])



Recommendations
