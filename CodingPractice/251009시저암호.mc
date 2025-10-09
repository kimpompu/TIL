# 시저 암호

```Java
class Solution {
    public String solution(String s, int n) {
        
        StringBuilder sb = new StringBuilder();
        char[] arr = s.toCharArray();
        for(char c : arr){
           if(c == ' '){
               sb.append(' ');
           }
            if(c >= 'a' && c<='z'){
                char moved = (char) ('a'+(c - 'a' +n)%26);
                sb.append(moved);
            }else if(c>='A' && c <= 'Z'){
                char moved = (char) ('A'+(c-'A'+n)%26);
                sb.append(moved);
            }
        }
        
        String answer = sb.toString();
        return answer;
    }
}
```
