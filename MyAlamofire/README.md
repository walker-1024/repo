### 看了下Alamofire的源码，仿照他的思路，用自己的代码实现了个别功能：

#### 实现了两个请求方法：

* get

  - 支持传入 String 型和 URL 型的url

  - 支持以字典格式传入请求参数并自动添加到url中（url为String时）
  - 支持以字典格式传入请求头信息
  - 支持设置字符串编码格式

* post

  - 支持传入 String 型和 URL 型的url
  - 支持以字典格式传入请求参数
  - 支持以字典格式传入请求头信息
  - 支持设置字符串编码格式

#### 支持的响应处理方法：

* responseJSON  返回结果为json类型
* responseString  返回结果为String类型
* responseData  返回结果为Data类型