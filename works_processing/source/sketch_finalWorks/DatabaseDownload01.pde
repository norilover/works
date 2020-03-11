/*
处理全球人工智能企业图表
 */
class LoadData {

  HashMap<Integer, DataCell> hm = new HashMap<Integer, DataCell>();
  String fileName;
  //初始化参数
  LoadData(String fileName) {
    this.fileName = fileName;
    JSONArray values;
    values = loadJSONArray(fileName);
    for (int i = 0; i < values.size(); i++) {
      DataCell toe = new DataCell();
      JSONObject value = values.getJSONObject(i);
      if (value.hasKey("id")) {
        toe.id = value.getInt("id", i);
      }
      if (value.hasKey("name")) {
        toe.name = value.getString("name", "i");
      }
      if (value.hasKey("value")) {
        toe.value = value.getInt("value", i);
      }

      if (value.hasKey("timeline")) {
        toe.timeline = value.getString("timeline", "i");
      }
      if (value.hasKey("events")) {
        //遍历数组
        JSONArray fValues = value.getJSONArray("events");
        for (int j = 0; j < fValues.size(); j++) {
          JSONObject obj = fValues.getJSONObject(j);
          toe.events[j] = obj.getString("event");
        }
      }
      //
      if (value.hasKey("talent")) {
        toe.talent = value.getInt("talent", i);
      }
      if (value.hasKey("superTalent")) {
        toe.superTalent = value.getInt("superTalent", i);
      }
      if (value.hasKey("rate")) {
        toe.rate = value.getString("rate", "i");
      }
      
      if (value.hasKey("period")) {
        toe.period = value.getString("period", "i");
      }
      if (value.hasKey("description")) {
        toe.description = value.getString("description", "i");
      }
      
      //存储数据
      hm.put(i, toe);
    }
  }
  //加载分布数据
  HashMap<Integer, DataCell> getData() {
    return hm;
  }
}
