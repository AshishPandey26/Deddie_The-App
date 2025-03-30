import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../../../core/widgets/curved_navbar.dart';
import '../../../../features/tasks/data/task_provider.dart';
import 'package:uuid/uuid.dart';
import '../../../tasks/domain/task.dart';
import '../../../social/domain/social_service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 1;
  final _uuid = const Uuid();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDeadline;
  bool _postToLinkedIn = false;
  bool _postToTwitter = false;

  // Light yellow theme colors
  static const Color primaryYellow = Color(0xFFFFF4D4);
  static const Color accentYellow = Color(0xFFFFE4A3);
  static const Color textColor = Color(0xFF2D2D2D);
  static const Color cardColor = Colors.white;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(minutes: 1), (_) => _checkDeadlines());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryYellow,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex == 0 ? 1 : _currentIndex - 1,
          children: [_buildHomePage(), _buildProfilePage()],
        ),
      ),
      bottomNavigationBar: CurvedNavBar(
        selectedIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            _showAddTaskDialog();
          } else {
            setState(() => _currentIndex = index);
          }
        },
      ),
    );
  }

  Widget _buildHomePage() {
    return Column(
      children: [
        _buildHeader('My Tasks'),
        Expanded(child: _buildTaskList(showAll: true)),
      ],
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Stay focused, be productive',
            style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList({bool showAll = false}) {
    final tasks = ref.watch(tasksProvider);

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildTaskCard(task),
        );
      },
    );
  }

  Widget _buildTaskCard(Task task) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _deleteTask(task.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.red),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          leading: GestureDetector(
            onTap: () => _toggleTaskCompletion(task.id),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: task.isCompleted ? accentYellow : Colors.transparent,
                border: Border.all(
                  color: task.isCompleted ? accentYellow : Colors.grey.shade400,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child:
                  task.isCompleted
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
            ),
          ),
          title: Text(
            task.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                task.description,
                style: TextStyle(
                  color: textColor.withOpacity(0.7),
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: _getDeadlineColor(task.deadline),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getFormattedDeadline(task.deadline),
                    style: TextStyle(
                      color: _getDeadlineColor(task.deadline),
                      fontSize: 12,
                    ),
                  ),
                  if (task.postToLinkedIn || task.postToTwitter) ...[
                    const SizedBox(width: 12),
                    if (task.postToLinkedIn)
                      const Icon(Icons.work, size: 14, color: textColor),
                    if (task.postToTwitter)
                      const Icon(
                        Icons.flutter_dash,
                        size: 14,
                        color: textColor,
                      ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePage() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: accentYellow,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 24),
                _buildStatItem('Tasks Completed', '12'),
                _buildStatItem('Tasks Pending', '5'),
                _buildStatItem('Social Posts', '3'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: textColor.withOpacity(0.8)),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  void _addTask(String title, String description, DateTime deadline) {
    final task = Task(
      id: _uuid.v4(),
      title: title,
      description: description,
      deadline: deadline,
      postToLinkedIn: _postToLinkedIn,
      postToTwitter: _postToTwitter,
    );
    ref.read(tasksProvider.notifier).addTask(task);
  }

  void _deleteTask(String taskId) {
    ref.read(tasksProvider.notifier).deleteTask(taskId);
  }

  void _toggleTaskCompletion(String taskId) {
    ref.read(tasksProvider.notifier).toggleTaskCompletion(taskId);
  }

  void _checkDeadlines() {
    final tasks = ref.read(tasksProvider);
    final now = DateTime.now();
    for (final task in tasks) {
      if (!task.isCompleted &&
          task.deadline.isBefore(now) &&
          (task.postToLinkedIn || task.postToTwitter)) {
        if (task.postToLinkedIn) {
          ref.read(socialServiceProvider).postToLinkedIn(task.title);
        }
        if (task.postToTwitter) {
          ref.read(socialServiceProvider).postToTwitter(task.title);
        }
      }
    }
  }

  String _getFormattedDeadline(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference < 0) return 'Overdue';
    if (difference < 7) return '$difference days left';
    return deadline.toString().split(' ')[0];
  }

  Color _getDeadlineColor(DateTime deadline) {
    final daysUntilDeadline = deadline.difference(DateTime.now()).inDays;
    if (daysUntilDeadline < 0) return Colors.red;
    if (daysUntilDeadline == 0) return Colors.orange;
    return Colors.green;
  }

  void _showAddTaskDialog() {
    _titleController.clear();
    _descriptionController.clear();
    _selectedDeadline = null;
    _postToLinkedIn = false;
    _postToTwitter = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => Container(
                  decoration: const BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Add New Task',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Task Title',
                          filled: true,
                          fillColor: primaryYellow.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: accentYellow),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          filled: true,
                          fillColor: primaryYellow.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: accentYellow),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (picked != null) {
                            setState(() => _selectedDeadline = picked);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: primaryYellow.withOpacity(0.1),
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color:
                                    _selectedDeadline != null
                                        ? accentYellow
                                        : Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _selectedDeadline != null
                                    ? _selectedDeadline.toString().split(' ')[0]
                                    : 'Select Deadline',
                                style: TextStyle(
                                  color:
                                      _selectedDeadline != null
                                          ? textColor
                                          : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: primaryYellow.withOpacity(0.1),
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Social Accountability',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'If you fail to complete this task by the deadline, we\'ll post about it on:',
                              style: TextStyle(
                                color: textColor.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    value: _postToLinkedIn,
                                    onChanged: (value) {
                                      setState(
                                        () => _postToLinkedIn = value ?? false,
                                      );
                                    },
                                    title: const Text('LinkedIn'),
                                    secondary: Icon(
                                      Icons.work,
                                      color:
                                          _postToLinkedIn
                                              ? accentYellow
                                              : Colors.grey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CheckboxListTile(
                                    value: _postToTwitter,
                                    onChanged: (value) {
                                      setState(
                                        () => _postToTwitter = value ?? false,
                                      );
                                    },
                                    title: const Text('Twitter'),
                                    secondary: Icon(
                                      Icons.flutter_dash,
                                      color:
                                          _postToTwitter
                                              ? accentYellow
                                              : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_titleController.text.isNotEmpty &&
                                _descriptionController.text.isNotEmpty &&
                                _selectedDeadline != null) {
                              _addTask(
                                _titleController.text,
                                _descriptionController.text,
                                _selectedDeadline!,
                              );
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentYellow,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Add Task',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
          ),
    );
  }

  void _showTaskDetails(Task task) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  task.description,
                  style: TextStyle(color: textColor.withOpacity(0.7)),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: _getDeadlineColor(task.deadline),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Deadline: ${task.deadline.toString().split(' ')[0]}',
                      style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _toggleTaskCompletion(task.id);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        task.isCompleted
                            ? Icons.refresh
                            : Icons.check_circle_outline,
                      ),
                      label: Text(
                        task.isCompleted ? 'Mark Incomplete' : 'Mark Complete',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentYellow,
                        foregroundColor: textColor,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        _deleteTask(task.id);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade100,
                        foregroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
