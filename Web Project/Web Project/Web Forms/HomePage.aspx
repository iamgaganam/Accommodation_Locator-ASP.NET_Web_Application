<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Web_Project.Web_Forms.HomePage" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            overflow: hidden;
            background-color: #000;
        }

        .video-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -1;
        }

        video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
            opacity: 0.5;
        }

        .content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: #fff;
            z-index: 1;
            animation: fadeIn 1s ease-in-out;
        }

        .title {
            font-size: 3em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .description {
            font-size: 1.3em;
            font-style: italic;
            opacity: 0.8;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }

        .button-container {
            margin-top: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

            .button-container button {
                margin: 0 10px;
                padding: 10px 20px;
                font-size: 1em;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1), 0 1px 3px rgba(0, 0, 0, 0.08);
            }

                .button-container button:hover {
                    opacity: 0.9;
                    transform: translateY(-3px);
                }

            .button-container .landlord {
                background-color: #3498db;
                color: white;
            }

            .button-container .warden {
                background-color: #e74c3c;
                color: white;
            }

            .button-container .student {
                background-color: #2ecc71;
                color: white;
            }

            .button-container .admin {
                background-color: #f39c12;
                color: white;
            }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translate(-50%, -60%);
            }

            to {
                opacity: 1;
                transform: translate(-50%, -50%);
            }
        }
    </style>
</head>
<body>
    <div class="video-container">
        <video id="bg-video" autoplay muted loop>
            <source src="NSBM.mp4" type="video/mp4">
            Your browser does not support the video tag.
        </video>
    </div>
    <div class="content">
        <div class="title">NSBM Accommodation Finder</div>
        <div class="description">Discover a tailored selection of accommodations designed to enhance your university experience.</div>

        <div class="button-container">
            <button class="landlord"><a href="Landlord/LandlordLogin.aspx" style="text-decoration: none; color: inherit;">Landlord</a></button>
            <button class="warden"><a href="Warden/WardenLogin.aspx" style="text-decoration: none; color: inherit;">Warden</a></button>
            <button class="student"><a href="Student/StudentLogin.aspx" style="text-decoration: none; color: inherit;">Student</a></button>
            <button class="admin"><a href="Admin/AdminLogin.aspx" style="text-decoration: none; color: inherit;">Admin</a></button>
        </div>
    </div>
</body>
</html>
