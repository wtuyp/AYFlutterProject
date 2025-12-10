

class PagingData<T> {
  int page;
  bool hasMore;
  List<T> list;

  PagingData({
    this.page = 1,
    this.hasMore = false,
    List<T>? list,
  }) : list = list ?? <T>[];

  int get nextPage => page + 1;
  int get firstPage => 1;
}