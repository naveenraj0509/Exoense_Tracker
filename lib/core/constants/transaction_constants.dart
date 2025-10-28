class TransactionConstants {
  // Transaction Types
  static const String expense = 'expense';
  static const String income = 'income';

  // Expense Categories
  static const List<String> expenseCategories = [
    'Shopping',
    'Grocery',
    'Coffee',
    'Utilities',
    'Entertainment',
    'Transportation',
    'Health',
    'Education',
    'Other',
  ];

  // Income Categories
  static const List<String> incomeCategories = [
    'Salary',
    'Freelance',
    'Business',
    'Investment',
    'Other Income',
  ];

  // All Categories
  static List<String> get allCategories => [
    ...expenseCategories,
    ...incomeCategories,
  ];

  // Check if category is income
  static bool isIncomeCategory(String category) =>
      incomeCategories.contains(category);

  // Check if category is expense
  static bool isExpenseCategory(String category) =>
      expenseCategories.contains(category);

  // Get categories for transaction type
  static List<String> getCategoriesForType(String type) {
    switch (type) {
      case expense:
        return expenseCategories;
      case income:
        return incomeCategories;
      default:
        return [];
    }
  }

  // Get default category for type
  static String getDefaultCategoryForType(String type) {
    final categories = getCategoriesForType(type);
    return categories.isNotEmpty ? categories.first : '';
  }

  // Get icon data for transaction type
  static int getIconCodeForType(String type) {
    return type == income ? 0xe227 : 0xe59c; // attach_money or shopping_bag
  }

  // Get color for transaction type
  static int getColorValueForType(String type) {
    return type == income ? 0xFF66BB6A : 0xFFE57373;
  }
}
