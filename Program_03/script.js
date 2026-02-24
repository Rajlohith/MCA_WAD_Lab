function register() {

    const name    = document.getElementById('name').value;
    const email   = document.getElementById('email').value;
    const mobile  = document.getElementById('mobile').value;
    const dob     = document.getElementById('dob').value;
    const blood   = document.getElementById('bloodGroup').value;
    const address = document.getElementById('address').value;

    const patterns = {
        name: /^[A-Za-z\s]{2,50}$/,
        email: /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/,
        mobile: /^[6-9]\d{9}$/
    };

    if (!patterns.name.test(name)) {alert("Invalid Name (Only letters, 2-50 characters)"); return; }
    if (!patterns.email.test(email)) {alert("Invalid Email"); return; }
    if (!patterns.mobile.test(mobile)) {alert("Invalid Mobile (Must start with 6-9 and contain 10 digits)"); return; }
    if (!dob) {alert("Please select Date of Birth"); return; }
    if (!blood) {alert("Please select Blood Group"); return; }
    if (address.length < 5) {alert("Address must be at least 5 characters"); return; }

    alert(
        "Registration Successful\n\n" +
        "Name: " + name + "\n" +
        "Email: " + email + "\n" +
        "Mobile: " + mobile + "\n" +
        "DOB: " + dob + "\n" +
        "Blood Group: " + blood + "\n" +
        "Address: " + address
    );
}