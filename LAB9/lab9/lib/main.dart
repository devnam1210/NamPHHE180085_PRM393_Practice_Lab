import 'package:flutter/material.dart';
import 'note_model.dart';
import 'storage_service.dart';

void main() {
  runApp(MaterialApp(home: NotesScreen(), debugShowCheckedModeBanner: false));
}

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final StorageService _storageService = StorageService();
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    _notes = await _storageService.loadNotes();
    _filteredNotes = _notes;
    setState(() {});
  }

  Future<void> _saveData() async {
    await _storageService.saveNotes(_notes);
    setState(() {
      _searchNotes(_searchController.text); // Cập nhật lại danh sách hiển thị
    });
  }

  void _searchNotes(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNotes = _notes;
      } else {
        _filteredNotes = _notes
            .where((n) => n.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showNoteDialog({Note? note}) {
    TextEditingController titleController = TextEditingController(text: note?.title ?? '');
    TextEditingController descController = TextEditingController(text: note?.description ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(note == null ? 'Thêm Ghi Chú' : 'Sửa Ghi Chú'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: 'Tiêu đề')),
            TextField(controller: descController, decoration: InputDecoration(labelText: 'Mô tả')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              if (note == null) {
                // ADD (Tạo ID ngẫu nhiên)
                _notes.add(Note(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    description: descController.text));
              } else {
                // EDIT
                note.title = titleController.text;
                note.description = descController.text;
              }
              _saveData(); // Gọi hàm auto-save
              Navigator.pop(context);
              // Điểm cộng (Bonus): Hiển thị SnackBar
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã lưu thành công!')));
            },
            child: Text('Lưu'),
          ),
        ],
      ),
    );
  }

  // Dialog Xác nhận Xóa (Bonus Lab 9.3)
  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xác nhận'),
        content: Text('Bạn có chắc chắn muốn xóa ghi chú này?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Hủy')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              _notes.removeWhere((n) => n.id == id);
              _saveData(); // Gọi hàm auto-save
              Navigator.pop(context);
            },
            child: Text('Xóa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('JSON Local Storage')),
      body: Column(
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchNotes,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // Danh sách hiển thị
          Expanded(
            child: _filteredNotes.isEmpty
                ? Center(child: Text('Không có dữ liệu'))
                : ListView.builder(
                    itemCount: _filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = _filteredNotes[index];
                      return Card(
                        child: ListTile(
                          title: Text(note.title, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(note.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showNoteDialog(note: note),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmDelete(note.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showNoteDialog(),
      ),
    );
  }
}

