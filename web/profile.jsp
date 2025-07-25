<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .custom-btn {
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 8px;
        padding: 5px 10px;
        font-size: 14px;
        cursor: pointer;
        margin-left: 10px;
    }
    .custom-btn:hover {
        background-color: #0056b3;
    }
</style>

<div class="card stat-card">
    <div class="card-body">
        <h5 class="card-title">Profile</h5>
        <p>
            <strong>Name:</strong>
            <input type="text" id="nameInput" value="${data.name}" style="border-radius: 8px; padding: 5px;" />
            <button type="button" class="custom-btn" onclick="submitName()">Save</button>
        </p>
        <p>
            <strong>Email:</strong> ${data.email}
            <button type="button" class="custom-btn" onclick="showEditEmailModal()">Edit</button>
        </p>
        <p>
            <strong>Phone:</strong> ${data.phone}
            <button type="button" class="custom-btn" onclick="showEditPhoneModal()">Edit</button>
        </p>
        <p>
            <strong>Gender:</strong>
            <select id="genderSelect" style="border-radius: 8px; padding: 5px;">
                <option value="Male" ${data.gender == 'Male' ? 'selected' : ''}>Male</option>
                <option value="Female" ${data.gender == 'Female' ? 'selected' : ''}>Female</option>
                <option value="Other" ${data.gender == 'Other' ? 'selected' : ''}>Other</option>
            </select>
            <button type="button" class="custom-btn" onclick="submitGender()">Save</button>
        </p>

        <p>
            <strong>Date of Birth:</strong>
            <fmt:formatDate value="${data.dateOfBirth}" pattern="dd/MM/yyyy" />
            <button type="button" class="custom-btn" onclick="showEditDobModal()">Edit</button>
        </p>

        <p>
            <strong>Shipping Address:</strong>
            ${data.shipping_address}
            <button type="button" class="custom-btn" onclick="showEditAddressModal()">Edit</button>
        </p>

        <button type="button" class="custom-btn" onclick="showChangePasswordModal()">Change Password</button>
    </div>               
</div>

<!-- Email Edit Modal -->
<div id="editEmailModal" style="display:none; position:fixed; top:30%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1000;">
    <form id="editEmailForm" onsubmit="submitNewEmail(event)">
        <label>Enter new email:</label>
        <input type="email" id="newEmailInput" required>
        <button type="submit">Send Confirmation</button>
        <button type="button" onclick="closeEditEmailModal()">Cancel</button>
    </form>
</div>
<!-- Token Modal -->
<div id="tokenModal" style="display:none; position:fixed; top:35%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1001;">
    <form id="tokenForm" onsubmit="submitToken(event)">
        <label>Enter confirmation code sent to your old email:</label>
        <input type="text" id="tokenInput" required>
        <button type="submit">Confirm</button>
        <button type="button" onclick="closeTokenModal()">Cancel</button>
    </form>
</div>
<!-- Phone Edit Modal -->
<div id="editPhoneModal" style="display:none; position:fixed; top:30%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1000;">
    <form id="editPhoneForm" onsubmit="submitNewPhone(event)">
        <label>Enter new phone number:</label>
        <input type="tel" id="newPhoneInput" required pattern="[0-9]{9,15}">
        <button type="submit">Send Confirmation</button>
        <button type="button" onclick="closeEditPhoneModal()">Cancel</button>
    </form>
</div>
<!-- Phone Token Modal -->
<div id="phoneTokenModal" style="display:none; position:fixed; top:35%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1001;">
    <form id="phoneTokenForm" onsubmit="submitPhoneToken(event)">
        <label>Enter confirmation code sent to your email:</label>
        <input type="text" id="phoneTokenInput" required>
        <button type="submit">Confirm</button>
        <button type="button" onclick="closePhoneTokenModal()">Cancel</button>
    </form>
</div>
<div id="modalOverlay" style="display:none; position:fixed; top:0; left:0; width:100vw; height:100vh; background:rgba(0,0,0,0.3); z-index:999;"></div>
<!-- Change Password Modal -->
<div id="changePasswordModal" style="display:none; position:fixed; top:30%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1000;">
    <form onsubmit="submitNewPassword(event)">
        <label>New Password:</label>
        <input type="password" id="newPassword" required minlength="8">
        <label>Confirm Password:</label>
        <input type="password" id="confirmPassword" required minlength="8">
        <button type="submit">Send Confirmation</button>
        <button type="button" onclick="closeChangePasswordModal()">Cancel</button>
    </form>
</div>
<!-- Verify Password Code Modal -->
<div id="verifyPasswordModal" style="display:none; position:fixed; top:35%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1001;">
    <form onsubmit="submitPasswordToken(event)">
        <label>Enter confirmation code sent to your email:</label>
        <input type="text" id="passwordTokenInput" required>
        <button type="submit">Confirm</button>
        <button type="button" onclick="closeVerifyPasswordModal()">Cancel</button>
    </form>
</div>
<!-- DoB Edit Modal -->
<div id="editDobModal" style="display:none; position:fixed; top:30%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1000;">
    <form id="editDobForm" onsubmit="submitNewDob(event)">
        <label>Day:</label>
        <input type="number" id="dobDay" min="1" max="31" required style="width:60px;"> /
        <label>Month:</label>
        <input type="number" id="dobMonth" min="1" max="12" required style="width:60px;"> /
        <label>Year:</label>
        <input type="number" id="dobYear" min="1900" max="2100" required style="width:80px;">
        <div id="dobError" style="color:red; font-size:13px; margin:5px 0;"></div>
        <button type="submit">Save</button>
        <button type="button" onclick="closeEditDobModal()">Cancel</button>
    </form>
</div>
<!-- Address Edit Modal -->
<div id="editAddressModal" style="display:none; position:fixed; top:20%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1000; min-width:350px;">
    <form id="editAddressForm" onsubmit="submitNewAddress(event)">
        <label>Province/City:</label>
        <select id="modalProvince" required style="width:100%; margin-bottom:5px;"></select>
        <label>District:</label>
        <select id="modalDistrict" required style="width:100%; margin-bottom:5px;" disabled></select>
        <label>Ward/Commune:</label>
        <select id="modalWard" required style="width:100%; margin-bottom:5px;" disabled></select>
        <label>Address Detail:</label>
        <input type="text" id="modalAddressDetail" maxlength="100" required style="width:100%; margin-bottom:5px;">
        <div id="addressError" style="color:red; font-size:13px; margin:5px 0;"></div>
        <button type="submit">Save</button>
        <button type="button" onclick="closeEditAddressModal()">Cancel</button>
    </form>
</div>
<script src="vietnam-provinces.json" type="application/json" id="locationsData"></script>
<script>
    function showEditEmailModal() {
        document.getElementById('editEmailModal').style.display = 'block';
        document.getElementById('modalOverlay').style.display = 'block';
    }
    function closeEditEmailModal() {
        document.getElementById('editEmailModal').style.display = 'none';
        document.getElementById('modalOverlay').style.display = 'none';
    }
    function showEditPhoneModal() {
        document.getElementById('editPhoneModal').style.display = 'block';
        document.getElementById('modalOverlay').style.display = 'block';
    }
    function closeEditPhoneModal() {
        document.getElementById('editPhoneModal').style.display = 'none';
        document.getElementById('modalOverlay').style.display = 'none';
    }

// AJAX: Send new email to server
    function submitNewEmail(event) {
        event.preventDefault();
        var newEmail = document.getElementById('newEmailInput').value;
        fetch('editProfile', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=editEmail&newEmail=' + encodeURIComponent(newEmail)
        })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        closeEditEmailModal();
                        showTokenModal();
                    } else {
                        alert(data.error || 'An error occurred!');
                    }
                });
    }

// Show token modal
    function showTokenModal() {
        document.getElementById('tokenModal').style.display = 'block';
        document.getElementById('modalOverlay').style.display = 'block';
    }
    function closeTokenModal() {
        document.getElementById('tokenModal').style.display = 'none';
        document.getElementById('modalOverlay').style.display = 'none';
    }

// AJAX: Submit token to server
    function submitToken(event) {
        event.preventDefault();
        var token = document.getElementById('tokenInput').value;
        fetch('editProfile', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=verifyEmailToken&token=' + encodeURIComponent(token)
        })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        closeTokenModal();
                        window.location.reload();
                    } else {
                        alert(data.error || 'Invalid confirmation code!');
                    }
                });
    }

// AJAX: Send new phone to server
    function submitNewPhone(event) {
        event.preventDefault();
        var newPhone = document.getElementById('newPhoneInput').value;
        fetch('editProfile', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=editPhone&newPhone=' + encodeURIComponent(newPhone)
        })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        closeEditPhoneModal();
                        showPhoneTokenModal();
                    } else {
                        alert(data.error || 'An error occurred!');
                    }
                });
    }

    function showPhoneTokenModal() {
        document.getElementById('phoneTokenModal').style.display = 'block';
        document.getElementById('modalOverlay').style.display = 'block';
    }
    function closePhoneTokenModal() {
        document.getElementById('phoneTokenModal').style.display = 'none';
        document.getElementById('modalOverlay').style.display = 'none';
    }

// AJAX: Submit phone token to server
    function submitPhoneToken(event) {
        event.preventDefault();
        var token = document.getElementById('phoneTokenInput').value;
        fetch('editProfile', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=verifyPhoneToken&token=' + encodeURIComponent(token)
        })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        closePhoneTokenModal();
                        window.location.reload();
                    } else {
                        alert(data.error || 'Invalid confirmation code!');
                    }
                });
    }

    function submitName() {
        const newName = document.getElementById('nameInput').value.trim();
        if (newName === "") {
            alert("Name cannot be empty!");
            return;
        }

        fetch('editProfile', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=editName&newName=' + encodeURIComponent(newName)
        })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        alert("Name updated successfully!");
                        window.location.reload();
                    } else {
                        alert(data.error || 'An error occurred!');
                    }
                })
                .catch(err => {
                    console.error(err);
                    alert('Connection error to server.');
                });
    }
    function showChangePasswordModal() {
        document.getElementById('changePasswordModal').style.display = 'block';
        document.getElementById('modalOverlay').style.display = 'block';
    }
    function closeChangePasswordModal() {
        document.getElementById('changePasswordModal').style.display = 'none';
        document.getElementById('modalOverlay').style.display = 'none';
    }
    function showVerifyPasswordModal() {
        document.getElementById('verifyPasswordModal').style.display = 'block';
        document.getElementById('modalOverlay').style.display = 'block';
    }
    function closeVerifyPasswordModal() {
        document.getElementById('verifyPasswordModal').style.display = 'none';
        document.getElementById('modalOverlay').style.display = 'none';
    }

    function submitNewPassword(event) {
        event.preventDefault();
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (newPassword !== confirmPassword) {
            alert("Passwords do not match!");
            return;
        }

        fetch('editProfile', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=initiatePasswordChange&newPassword=' + encodeURIComponent(newPassword)
        })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        closeChangePasswordModal();
                        showVerifyPasswordModal();
                    } else {
                        alert(data.error || "Error sending confirmation code.");
                    }
                });
    }

    function submitPasswordToken(event) {
        event.preventDefault();
        const token = document.getElementById('passwordTokenInput').value;

        fetch('editProfile', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=verifyPasswordToken&token=' + encodeURIComponent(token)
        })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        closeVerifyPasswordModal();
                        alert("Password changed successfully!");
                        window.location.reload();
                    } else {
                        alert(data.error || "Invalid confirmation code!");
                    }
                });
    }
    function submitGender() {
        const newGender = document.getElementById('genderSelect').value;

        fetch('editProfile', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=editGender&newGender=' + encodeURIComponent(newGender)
        })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        alert("Gender updated successfully!");
                        window.location.reload();
                    } else {
                        alert(data.error || 'An error occurred!');
                    }
                })
                .catch(err => {
                    console.error(err);
                    alert('Connection error to server.');
                });
    }

    function showProfileSuccess(msg) {
        alert(msg);
    }
// --- DoB Inline Logic ---
function showEditDobModal() {
    // Pre-fill with current DoB if available
    const dob = "${data.dateOfBirth}";
    if (dob && dob !== 'null') {
        let d = null;
        if (dob.includes('-')) d = new Date(dob);
        else if (dob.includes('/')) {
            let [day, month, year] = dob.split('/');
            d = new Date(`${year}-${month}-${day}`);
        }
        if (d && !isNaN(d)) {
            document.getElementById('dobDay').value = d.getDate();
            document.getElementById('dobMonth').value = d.getMonth() + 1;
            document.getElementById('dobYear').value = d.getFullYear();
        }
    }
    document.getElementById('dobError').textContent = '';
    document.getElementById('editDobModal').style.display = 'block';
    document.getElementById('modalOverlay').style.display = 'block';
}
function closeEditDobModal() {
    document.getElementById('editDobModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
}
function isValidDate(d, m, y) {
    const date = new Date(y, m - 1, d);
    return date.getFullYear() === y && date.getMonth() === m - 1 && date.getDate() === d;
}
function submitNewDob(event) {
    event.preventDefault();
    const day = parseInt(document.getElementById('dobDay').value, 10);
    const month = parseInt(document.getElementById('dobMonth').value, 10);
    const year = parseInt(document.getElementById('dobYear').value, 10);
    const now = new Date();
    const dobError = document.getElementById('dobError');
    dobError.textContent = '';
    if (!isValidDate(day, month, year)) {
        dobError.textContent = 'Invalid date!';
        return;
    }
    const dob = new Date(year, month - 1, day);
    const age = now.getFullYear() - dob.getFullYear() - (now < new Date(now.getFullYear(), dob.getMonth(), dob.getDate()) ? 1 : 0);
    if (age < 13 || age > 120) {
        dobError.textContent = 'Age must be between 13 and 120.';
        return;
    }
    // Format as dd/MM/yyyy
    const dobStr = (day < 10 ? '0' : '') + day + '/' + (month < 10 ? '0' : '') + month + '/' + year;
    fetch('editProfile', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=editDoB&newDoB=' + encodeURIComponent(dobStr)
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            alert('Date of Birth updated successfully!');
            window.location.reload();
        } else {
            dobError.textContent = data.error || 'An error occurred!';
        }
    });
}
// --- Address Inline Logic ---
let locationsData = [];
fetch('vietnam-provinces.json')
    .then(response => response.json())
    .then(data => {
        locationsData = data;
        populateProvinces();
        setAddressInputs();
    });
function populateProvinces() {
    const provinceSelect = document.getElementById('province');
    provinceSelect.innerHTML = '<option value="">-- Select province --</option>';
    locationsData.forEach(province => {
        const option = document.createElement('option');
        option.value = province.name;
        option.textContent = province.name;
        provinceSelect.appendChild(option);
    });
    document.getElementById('district').innerHTML = '<option value="">-- Select district --</option>';
    document.getElementById('district').disabled = true;
    document.getElementById('ward').innerHTML = '<option value="">-- Select ward --</option>';
    document.getElementById('ward').disabled = true;
}
document.getElementById('province').addEventListener('change', function() {
    const provinceName = this.value;
    const province = locationsData.find(p => p.name === provinceName);
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');
    if (province) {
        districtSelect.innerHTML = '<option value="">-- Select district --</option>';
        province.districts.forEach(district => {
            const option = document.createElement('option');
            option.value = district.name;
            option.textContent = district.name;
            districtSelect.appendChild(option);
        });
        districtSelect.disabled = false;
        wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
        wardSelect.disabled = true;
    } else {
        districtSelect.innerHTML = '<option value="">-- Select district --</option>';
        districtSelect.disabled = true;
        wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
        wardSelect.disabled = true;
    }
});
document.getElementById('district').addEventListener('change', function() {
    const provinceName = document.getElementById('province').value;
    const province = locationsData.find(p => p.name === provinceName);
    const districtName = this.value;
    const district = province ? province.districts.find(d => d.name === districtName) : null;
    const wardSelect = document.getElementById('ward');
    if (district) {
        wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
        district.wards.forEach(ward => {
            const option = document.createElement('option');
            option.value = ward.name;
            option.textContent = ward.name;
            wardSelect.appendChild(option);
        });
        wardSelect.disabled = false;
    } else {
        wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
        wardSelect.disabled = true;
    }
});
function setAddressInputs() {
    // Pre-fill with current address if available
    const address = "${data.shipping_address}";
    let province = '', district = '', ward = '', detail = '';
    if (address && address.split(',')) {
        const parts = address.split(',').map(s => s.trim());
        if (parts.length >= 4) {
            detail = parts[0];
            ward = parts[1];
            district = parts[2];
            province = parts[3];
        }
    }
    document.getElementById('addressDetail').value = detail;
    setTimeout(() => {
        document.getElementById('province').value = province;
        document.getElementById('province').dispatchEvent(new Event('change'));
        setTimeout(() => {
            document.getElementById('district').value = district;
            document.getElementById('district').dispatchEvent(new Event('change'));
            setTimeout(() => {
                document.getElementById('ward').value = ward;
            }, 100);
        }, 100);
    }, 100);
}
function submitAddress() {
    const province = document.getElementById('province').value;
    const district = document.getElementById('district').value;
    const ward = document.getElementById('ward').value;
    const detail = document.getElementById('addressDetail').value.trim();
    const addressError = document.getElementById('addressError');
    addressError.textContent = '';
    if (!province || !district || !ward || !detail) {
        addressError.textContent = 'All fields are required.';
        return;
    }
    if (detail.length < 2 || detail.length > 100) {
        addressError.textContent = 'Address detail must be 2-100 characters.';
        return;
    }
    if (/[<>{}\\[\\]$%]/.test(detail)) {
        addressError.textContent = 'Address contains invalid characters.';
        return;
    }
    // Format: detail, ward, district, province
    const fullAddress = `${detail}, ${ward}, ${district}, ${province}`;
    fetch('editProfile', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=editAddress&newAddress=' + encodeURIComponent(fullAddress)
    })
    .then(res => res.json())
    .then(data => {
        console.log(data); // <-- Add this for debugging
        if (data.success) {
            showProfileSuccess('Shipping Address updated successfully!');
            window.location.reload(); // <-- Add this
        } else {
            addressError.textContent = data.error || 'An error occurred!';
        }
    });
}

function showEditAddressModal() {
    populateModalProvinces();
    // Pre-fill with current address if available
    const address = "${data.shipping_address}";
    let province = '', district = '', ward = '', detail = '';
    if (address && address.split(',')) {
        const parts = address.split(',').map(s => s.trim());
        if (parts.length >= 4) {
            detail = parts[0];
            ward = parts[1];
            district = parts[2];
            province = parts[3];
        }
    }
    document.getElementById('modalAddressDetail').value = detail;
    setTimeout(() => {
        document.getElementById('modalProvince').value = province;
        document.getElementById('modalProvince').dispatchEvent(new Event('change'));
        setTimeout(() => {
            document.getElementById('modalDistrict').value = district;
            document.getElementById('modalDistrict').dispatchEvent(new Event('change'));
            setTimeout(() => {
                document.getElementById('modalWard').value = ward;
            }, 100);
        }, 100);
    }, 100);
    document.getElementById('addressError').textContent = '';
    document.getElementById('editAddressModal').style.display = 'block';
    document.getElementById('modalOverlay').style.display = 'block';

    // Attach event listeners only once
    if (!window._modalProvinceListenerAdded) {
        document.getElementById('modalProvince').addEventListener('change', function() {
            const provinceName = this.value;
            const province = locationsData.find(p => p.name === provinceName);
            const districtSelect = document.getElementById('modalDistrict');
            const wardSelect = document.getElementById('modalWard');
            if (province) {
                districtSelect.innerHTML = '<option value="">-- Select district --</option>';
                province.districts.forEach(district => {
                    const option = document.createElement('option');
                    option.value = district.name;
                    option.textContent = district.name;
                    districtSelect.appendChild(option);
                });
                districtSelect.disabled = false;
                wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
                wardSelect.disabled = true;
            } else {
                districtSelect.innerHTML = '<option value="">-- Select district --</option>';
                districtSelect.disabled = true;
                wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
                wardSelect.disabled = true;
            }
        });
        window._modalProvinceListenerAdded = true;
    }
    if (!window._modalDistrictListenerAdded) {
        document.getElementById('modalDistrict').addEventListener('change', function() {
            const provinceName = document.getElementById('modalProvince').value;
            const province = locationsData.find(p => p.name === provinceName);
            const districtName = this.value;
            const district = province ? province.districts.find(d => d.name === districtName) : null;
            const wardSelect = document.getElementById('modalWard');
            if (district) {
                wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
                district.wards.forEach(ward => {
                    const option = document.createElement('option');
                    option.value = ward.name;
                    option.textContent = ward.name;
                    wardSelect.appendChild(option);
                });
                wardSelect.disabled = false;
            } else {
                wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
                wardSelect.disabled = true;
            }
        });
        window._modalDistrictListenerAdded = true;
    }
}
function closeEditAddressModal() {
    document.getElementById('editAddressModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
}
function populateModalProvinces() {
    const provinceSelect = document.getElementById('modalProvince');
    const districtSelect = document.getElementById('modalDistrict');
    const wardSelect = document.getElementById('modalWard');
    provinceSelect.innerHTML = '<option value="">-- Select province --</option>';
    locationsData.forEach(province => {
        const option = document.createElement('option');
        option.value = province.name;
        option.textContent = province.name;
        provinceSelect.appendChild(option);
    });
    districtSelect.innerHTML = '<option value="">-- Select district --</option>';
    districtSelect.disabled = true;
    wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
    wardSelect.disabled = true;
}
document.getElementById('modalProvince').addEventListener('change', function() {
    const provinceName = this.value;
    const province = locationsData.find(p => p.name === provinceName);
    const districtSelect = document.getElementById('modalDistrict');
    const wardSelect = document.getElementById('modalWard');
    if (province) {
        districtSelect.innerHTML = '<option value="">-- Select district --</option>';
        province.districts.forEach(district => {
            const option = document.createElement('option');
            option.value = district.name;
            option.textContent = district.name;
            districtSelect.appendChild(option);
        });
        districtSelect.disabled = false;
        wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
        wardSelect.disabled = true;
    } else {
        districtSelect.innerHTML = '<option value="">-- Select district --</option>';
        districtSelect.disabled = true;
        wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
        wardSelect.disabled = true;
    }
});
document.getElementById('modalDistrict').addEventListener('change', function() {
    const provinceName = document.getElementById('modalProvince').value;
    const province = locationsData.find(p => p.name === provinceName);
    const districtName = this.value;
    const district = province ? province.districts.find(d => d.name === districtName) : null;
    const wardSelect = document.getElementById('modalWard');
    if (district) {
        wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
        district.wards.forEach(ward => {
            const option = document.createElement('option');
            option.value = ward.name;
            option.textContent = ward.name;
            wardSelect.appendChild(option);
        });
        wardSelect.disabled = false;
    } else {
        wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
        wardSelect.disabled = true;
    }
});
function submitNewAddress(event) {
    event.preventDefault();
    const province = document.getElementById('modalProvince').value;
    const district = document.getElementById('modalDistrict').value;
    const ward = document.getElementById('modalWard').value;
    const detail = document.getElementById('modalAddressDetail').value.trim();
    const addressError = document.getElementById('addressError');
    addressError.textContent = '';
    if (!province || !district || !ward || !detail) {
        addressError.textContent = 'All fields are required.';
        return;
    }
    if (detail.length < 2 || detail.length > 100) {
        addressError.textContent = 'Address detail must be 2-100 characters.';
        return;
    }
    if (/[<>{}\\[\\]$%]/.test(detail)) {
        addressError.textContent = 'Address contains invalid characters.';
        return;
    }
    // Format: detail, ward, district, province
    const fullAddress = `${detail}, ${ward}, ${district}, ${province}`;
    fetch('editProfile', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=editAddress&newAddress=' + encodeURIComponent(fullAddress)
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            alert('Shipping Address updated successfully!');
            window.location.reload();
        } else {
            addressError.textContent = data.error || 'An error occurred!';
        }
    });
}

</script>

