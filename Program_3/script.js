function submitForm(e) {
    const get = id => document.getElementById(id).value;

    const name   = get('Name');
    const email  = get('email');
    const mobile = get('mobile');
    const blood  = document.getElementById('bloodGroup').value;
    const gender = document.querySelector('input[name="gender"]:checked');
    const address = get('address');

    const patterns = {
        name: /^[A-Za-z\s'-]{2,50}$/,
        email: /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/,
        mobile: /^[6-9]\d{9}$/
    };

    if (!patterns.name.test(name))     { alert("Invalid Name");       return; }
    if (!patterns.email.test(email))   { alert("Invalid Email");      return; }
    if (!patterns.mobile.test(mobile)) { alert("Invalid Mobile");     return; }
    if (!blood)                        { alert("Select Blood Group");  return; }
    if (!gender)                       { alert("Select Gender");       return; }

    alert(
        "Resgistration Successful\n" +
        "Name: " + name + "\n" +
        "Email: " + email + "\n" +
        "Mobile: " + mobile + "\n" +
        "Blood Group: " + blood + "\n" +
        "Gender: " + gender.value + "\n" +
        "Address: "     + address
    );

    this.reset();
};