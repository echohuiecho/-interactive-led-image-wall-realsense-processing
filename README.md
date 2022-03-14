# Posture Detection using PoseNet in Real-time - Interactive LED Image wall
## :question: About
This is an interactive installation to turn audience poses with real-time pose detection techniques into the control of images and hashtags on the LED image wall. With the deep learning TensorFlow model PoseNet and RealSense depth camera, we have developed a program in Processing to perform real-time gesture control.

It was co-developed by me and [Chan Long Fung Lazarus](https://www.lazaruschan.com/) as a creative technologist and a new media artist. It was a commissioned project in ARCH “Arts X Tech” Exhibition invited by the [13th Arts Ambassadors-in-School Scheme](https://www.hkadc.org.hk/en/whats-on/past-events/13th-aaiss-youth-arts-week-arts-x-tech-interactive-exhibition) organised by the Hong Kong Arts Development Council (HKADC).

This project was an extension of an AR artwork Life as usual by [Natalie Lo Lai-lai](https://www.lolailai.com/). The screen recordings of the Instagram AR filter uploaded by the users are stored in our database, and they are converted to GIF animation to our Processing code as GIF assets remotely every day.

## :hammer: Technologies
- Processing (JAVA)
- PoseNet (Deep Learning TensorFlow model)

## :star: Features
### Posture Detection using PoseNet
The audiences' pose positions are mapped to the coordinates. The GIFs and Hashtag images position is controlled by the attractor class so that they are slowly attracted to the pose coordinates.

<img src="https://videoapi-muybridge.vimeocdn.com/animated-thumbnails/image/3136387b-7dbd-441e-a815-6c0d83913afc.gif?ClientID=vimeo-core-prod&Date=1647244724&Signature=e38e9f0ccd01dce00838634a6b8554d7edc87831" /><br/>

![image](https://uploads-ssl.webflow.com/603fbf7c21375f0867e94c5c/622ed44a41ba31c6a015525d_MIC02580.jpg)

### What is PoseNet?
PoseNet is a deep learning TensorFlow model that allows you to estimate human pose by detecting body parts such as elbows, hips, wrists, knees, ankles, and form a skeleton structure of your pose by joining these points.

![image](https://uploads-ssl.webflow.com/603fbf7c21375f0867e94c5c/622edc818c724d1105bd0025_Posenet_keypoints.png)

## :clap: Acknowledgements
- [Intel RealSense for Procesing library](https://github.com/cansik/realsense-processing) maintained by [cansik](https://github.com/cansik)
- [GifAnimation Processing Library](https://github.com/extrapixel/gif-animation/tree/3.0)
- [Processing](https://processing.org/)

## :page_facing_up: License
[CC BY-NC-ND](https://creativecommons.org/licenses/by-nc-nd/4.0/)