# JadenCase 문자열 만들기
```Java
class Solution {
    public String solution(String s) {
        StringBuilder sb = new StringBuilder();
        boolean isFirst = true;
        
        String lowcase = s.toLowerCase();
        
        for(char c : lowcase.toCharArray()){
            if(c == ' '){
                sb.append(c);
                isFirst = true;
            }else{
                if(isFirst){
                    sb.append(Character.toUpperCase(c));
                    isFirst = false;
                }else{
                    sb.append(c);
                }
            }
        }
        
        String answer = sb.toString();
        return answer;
    }
}
```
