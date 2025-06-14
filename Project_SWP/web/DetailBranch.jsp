<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Branch Detail</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css">
    <style>
        .loading-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 9999;
        }
        .spinner {
            position: absolute;
            top: 50%; left: 50%;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #3498db;
            border-radius: 50%;
            width: 40px; height: 40px;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">Badminton Management</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <button class="nav-link" onclick="history.back()">Back</button>
            </li>
        </ul>
    </div>
</nav>

<div class="container-fluid mt-3">
    <div class="row">
        <div class="col-md-2">
            <jsp:include page="Sidebar.jsp" />
        </div>
        <div class="col-md-10">
            <h2>Branch Detail: ${area_id}</h2>

            <!-- Area Info -->
            <div class="card mb-4">
                <div class="card-body">
                    <h4 class="card-title mb-3">Branch Information</h4>
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Name:</strong> ${areaDetail.name}</p>
                            <p><strong>Location:</strong> ${areaDetail.location}</p>
                            <p><strong>Open Time:</strong> ${areaDetail.openTime}</p>
                            <p><strong>Close Time:</strong> ${areaDetail.closeTime}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Description:</strong> ${areaDetail.description}</p>
                            <p><strong>Manager (Host):</strong> ${areaDetail.managerName}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Images -->
            <h4>Images</h4>
            <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#addImageModal">+ Add Image</button>
            <table id="table" class="table table-bordered">
                <thead>
                    <tr>
                        <th>ImageID</th>
                        <th>Image</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="image" items="${areaImages}">
                        <tr>
                            <td>${image.image_id}</td>
                            <td><img src="${image.imageUrl}" alt="Branch Image" width="120"></td>
                            <td>
                                <a href="delete-image?image_id=${image.image_id}&area_id=${image.area_id}" onclick="return confirmDelete()" class="btn btn-danger">Delete</a>
                                <button class="btn btn-warning" data-toggle="modal" data-target="#updateImageModal${image.image_id}">Update</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Services -->
            <h4 class="mt-5">Services</h4>
            <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#addServiceModal">+ Add Service</button>
            <table id="table2" class="table table-bordered">
                <thead>
                    <tr>
                        <th>Service Name</th>
                        <th>Price</th>
                        <th>Description</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${areaAllServices}">
                        <tr>
                            <td>${s.service.serviceName}</td>
                            <td>${s.service.price}</td>
                            <td>${s.service.description}</td>
                            <td>
                                <a href="remove-service?dormServiceID=${s.dormServiceID}&area_id=${area_id}" onclick="return confirmDelete()" class="btn btn-danger">Remove</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <h4 class="mt-5">Courts in this Area</h4>
<table class="table table-bordered" id="courtsTable">
    <thead>
        <tr>
            <th>#</th>
            <th>Court Number</th>
            <th>Type</th>
            <th>Floor</th>
            <th>Lighting</th>
            <th>Description</th>
            <th>Image</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="court" items="${areaCourts}" varStatus="loop">
            <tr>
                <td>${loop.count}</td>
                <td>${court.courtNumber}</td>
                <td>${court.type}</td>
                <td>${court.floorMaterial}</td>
                <td>${court.lighting}</td>
                <td>${court.description}</td>
                <td>
                    <c:if test="${not empty court.imageUrl}">
                        <img src="${court.imageUrl}" alt="court image" width="100">
                    </c:if>
                </td>
                <td>${court.status}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

            <!-- Add Image Modal -->
          <div class="modal fade" id="addImageModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <form action="add-image" method="post" enctype="multipart/form-data" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add Image</h5>
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="area_id" value="${area_id}" />
                <div class="form-group">
                    <label for="image">Select Image</label>
                    <input type="file" class="form-control" name="image" id="image" accept="image/*" required />
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">Add</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </form>
    </div>
</div>
            <!-- Add Service Modal -->
          <div class="modal fade" id="addServiceModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <form action="add-service-branch" method="post" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add Service to Area</h5>
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="area_id" value="${area_id}" />
                <div class="form-group">
                    <label>Select Service</label>
                    <select name="service_id" class="form-control" required>
                        <c:forEach var="service" items="${allServices}">
                            <option value="${service.services_id}">${service.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">Add</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </form>
    </div>
</div>
            <!-- Update Image Modals -->
            <c:forEach var="image" items="${areaImages}">
                <div class="modal fade" id="updateImageModal${image.imageID}" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <form action="update-image" method="post" enctype="multipart/form-data" class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Update Image</h5>
                                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="area_id" value="${area_id}" />
                                <input type="hidden" name="imageID" value="${image.image_id}" />
                                <div class="form-group">
                                    <label for="image">New Image</label>
                                    <input type="file" class="form-control" name="image" required />
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-warning">Update</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </c:forEach>

        </div>
    </div>
</div>

<div class="loading-overlay">
    <div class="spinner"></div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>
<script>
    $(document).ready(function () {
        $('#table, #table2').DataTable({pageLength: 5, lengthChange: false});
    });

    function confirmDelete() {
        return confirm("Do you want to delete this?");
    }
</script>
</body>
</html>
