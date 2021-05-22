
 # Content Compression & Hugging
 
horizontal, vertical 축으로 분류할 수 있음

**Compression**: 한정된 공간 내에서 두 개의 속성이 경합을 벌일 때 ex. 두 UILabel의 text가 서로 너무 길 때  
priority가 높은 쪽에 text에 알맞은 공간을 제공(상대보다 길든, 짧든) <-> 상대는 남는 공간 내에서 말줄임 

<img width="484" alt="무제" src="https://user-images.githubusercontent.com/59492694/119210602-08ef1f80-bae8-11eb-906b-fb15161ba965.png">    

``` 
productLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
macbookLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
```

<img width="489" alt="무제 2" src="https://user-images.githubusercontent.com/59492694/119210604-0b517980-bae8-11eb-91b3-c02e460bf905.png">

```
productLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
macbookLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
```

**Hugging**: 한정된 공간을 두 개의 속성이 나눠서 채워야 할 때 ex. 두 UILabel이 view를 다 채우지 못하고 공간이 남을 때   
priority가 높은 쪽에 text에 알맞은 공간을 제공(상대보다 길든, 짧든) <-> 상대는 남는 공간을 다 채움   

<img width="474" alt="무제 3" src="https://user-images.githubusercontent.com/59492694/119210605-0bea1000-bae8-11eb-9d42-66ac642966b2.png">

```
productLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)              
macbookLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)   
```
