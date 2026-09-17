import 'dart:async';

void main() {
  print("--- EXERCISE 3 ---");
  
  // 1. Các lệnh đồng bộ (Synchronous) luôn được thực thi trước tiên từ trên xuống dưới
  print("1. Lệnh đồng bộ (Synchronous) chạy đầu tiên.");

  // 2. Future đưa tác vụ vào Event Queue (Macrotask) 
  Future(() => print("3. Future callback chạy cuối cùng (Event Queue)."));

  // 3. scheduleMicrotask đưa tác vụ vào Microtask Queue 
  scheduleMicrotask(() => print("2. Microtask chạy trước Event callback."));
  
  print("1b. Lệnh đồng bộ tiếp theo chạy ngay sau đó.");
}