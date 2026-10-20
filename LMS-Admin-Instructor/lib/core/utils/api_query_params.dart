class ApiQueryParams {
  static Map<String, dynamic> pagination({int? page, int? pageSize, String? search}) {
    return {
      if (page != null) 'page': page,
      if (pageSize != null) 'page_size': pageSize,
      if (search != null && search.isNotEmpty) 'search': search,
    };
  }
}
