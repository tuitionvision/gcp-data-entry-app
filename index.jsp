<!DOCTYPE html>
<html>
<head>
    <title>Data Entry Application</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        .container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); max-width: 600px; margin: auto; }
        h2 { color: #333; text-align: center; margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; }
        input[type="date"],
        input[type="number"],
        input[type="text"],
        textarea {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea { resize: vertical; min-height: 80px; }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .data-display {
            margin-top: 30px;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }
        .data-item {
            background-color: #e9ecef;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }
        .data-item strong {
            color: #555;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Enter Data</h2>
        <form action="data" method="post">
            <label for="date">Date:</label>
            <input type="date" id="date" name="date" required><br>

            <label for="amount">Amount:</label>
            <input type="number" id="amount" name="amount" step="0.01" required><br>

            <label for="remark">Remark:</label>
            <input type="text" id="remark" name="remark" required><br>

            <label for="comment">Comment:</label>
            <textarea id="comment" name="comment" rows="4"></textarea><br>

            <input type="submit" value="Submit Data">
        </form>

        <%
            // Display submitted data if available (after form submission)
            String submittedDate = (String) request.getAttribute("submittedDate");
            String submittedAmount = (String) request.getAttribute("submittedAmount");
            String submittedRemark = (String) request.getAttribute("submittedRemark");
            String submittedComment = (String) request.getAttribute("submittedComment");

            if (submittedDate != null) {
        %>
        <div class="data-display">
            <h3>Submitted Data:</h3>
            <div class="data-item">
                <strong>Date:</strong> <%= submittedDate %><br>
                <strong>Amount:</strong> <%= submittedAmount %><br>
                <strong>Remark:</strong> <%= submittedRemark %><br>
                <strong>Comment:</strong> <%= submittedComment %><br>
            </div>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>