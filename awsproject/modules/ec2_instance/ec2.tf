# provision EC2 instance with SSM agent enabled  
data "template_file" "startup" {
 template = file("${path.module}/ssm-agent-installer.sh")
}

resource "aws_instance" "jenkins_master" {
 ami                    = "ami-09d56f8956ab235b3"
 instance_type          = "t2.medium"
 subnet_id              = var.default_public_subnet_id
 vpc_security_group_ids = [var.jenkins_sg_id]
 iam_instance_profile = var.dev_iam_instance_profile

root_block_device {
delete_on_termination = true
volume_type           = "gp2"
volume_size           = 100
}

tags = {
 Name = "pilot_jenkins_master"
 solution = var.solution
 environment = var.environment
}
user_data = data.template_file.startup.rendered
}

/*
resource "aws_instance" "wp_radius_server" {
  ami           = "ami-0022f774911c1d690"
  instance_type = "t2.medium"
  key_name = "gmarket_nat_kp"
  iam_instance_profile = "EC2DomainJoin"
  security_groups = [var.dev_ec2_sg]
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = 30
    volume_type           = "gp2"
    
  } 
  tags = {
    Name = "gmarket_radius_instance"
    environment = var.environment
    solution = var.solution
  }

}

*/


# net user Administrator Mcs_LT@0422
#$Password = Read-Host -AsSecureString
#New-LocalUser "Surya" -Password $Password
# net user Surya Mcs_qa_new@05

#Add-LocalGroupMember -Group Administrators -Member Surya
#$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)
  