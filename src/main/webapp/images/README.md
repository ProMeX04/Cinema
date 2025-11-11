# Thư mục lưu trữ ảnh

## Cấu trúc thư mục

```
images/
├── movies/          # Ảnh poster/phim
└── README.md        # File này
```

## Cách sử dụng

### Cách 1: Lưu ảnh trong thư mục này (Local Storage)

1. Đặt file ảnh vào thư mục `images/movies/`
   - Ví dụ: `images/movies/movie-1.jpg`
   
2. Trong database, lưu đường dẫn tương đối:
   ```sql
   UPDATE Movie SET imageUrl = 'images/movies/movie-1.jpg' WHERE id = 1;
   ```

3. Hoặc đường dẫn tuyệt đối từ root:
   ```sql
   UPDATE Movie SET imageUrl = '/cinema/images/movies/movie-1.jpg' WHERE id = 1;
   ```

### Cách 2: Sử dụng URL từ external source (CDN/Cloud Storage)

Lưu URL đầy đủ vào database:
```sql
UPDATE Movie SET imageUrl = 'https://example.com/images/movie-1.jpg' WHERE id = 1;
```

### Cách 3: Sử dụng đường dẫn tương đối từ context path

Nếu context path là `/cinema`:
```sql
UPDATE Movie SET imageUrl = 'images/movies/movie-1.jpg' WHERE id = 1;
```

Sau đó trong JSP sẽ tự động resolve thành: `/cinema/images/movies/movie-1.jpg`

## Lưu ý

- Tên file nên có định dạng rõ ràng: `movie-{id}-{title}.jpg`
- Kích thước ảnh khuyến nghị: 300x400px cho poster
- Định dạng hỗ trợ: JPG, PNG, WebP
- Nếu ảnh không tồn tại, hệ thống sẽ hiển thị placeholder SVG

