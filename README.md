# Adaptive-barrier-method-based-image-processing-task-partition-and-allocation
This is a novel adaptive barrier algorithm to solve non-convex and non-linear optimization problem. In our application scenario, it is used to optimize the strategy of partial offloading of image processing tasks among a group of distributed devices. The distributed image processing systems design and algorithm implementation are detailed in our paper on IEEE Transaction on Mobile Computing:
<div align=center><img width="454" alt="Screen Shot 2021-09-08 at 4 26 40 PM" src="https://user-images.githubusercontent.com/37515653/132580703-1229099a-b174-4130-b243-490b755c8c8d.png">

<div align=left> Application scenario:
  
<div align=center><img width="383" alt="Screen Shot 2021-09-08 at 4 33 49 PM" src="https://user-images.githubusercontent.com/37515653/132581444-b848022a-19a9-454e-abab-d58501d20afe.png">
  
<div align=left>System modelling of partial offloaidng of image processing tasks:
 
<div align=center><img width="381" alt="Screen Shot 2021-09-09 at 9 08 20 AM" src="https://user-images.githubusercontent.com/37515653/132691595-a39ffd44-bda8-4b14-ac24-867793297ad1.png">
  
<div align=left>Original Optimization problem:
 
<div align=center><img width="403" alt="Screen Shot 2021-09-09 at 10 21 19 AM" src="https://user-images.githubusercontent.com/37515653/132703567-f519881a-3563-4e8a-99bb-8b2ca4d2c453.png">
 
<div align=left>Optimization problem with inequity constraints eliminated:
 
<div align=center><img width="393" alt="Screen Shot 2021-09-09 at 10 25 24 AM" src="https://user-images.githubusercontent.com/37515653/132704226-b4e4738a-64c5-48ea-9b3e-b65a1de9de60.png">

<div align=left>Algorithm of adaptive barrier method based on Adadelta gradient descent:
 
<div align=center><img width="415" alt="Screen Shot 2021-09-09 at 10 26 19 AM" src="https://user-images.githubusercontent.com/37515653/132704378-5d5f6c8b-dab5-4463-9981-e189891b1f9a.png">


 <div align=left>Algorithm performance:
 
<div align=center><img width="776" alt="Screen Shot 2021-09-09 at 10 29 12 AM" src="https://user-images.githubusercontent.com/37515653/132704843-b061dfa9-3857-4683-9a05-274aeba9cdac.png">
